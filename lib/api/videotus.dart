import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cross_file/cross_file.dart';
import 'package:learningapp/models/video_model.dart';
import 'package:tusc/tusc.dart';

const String baseUrl = 'https://api.crescentlearning.org';

Future<bool> videoUploadTUS({
  required String token,
  required File videoFile,
  required int duration,
  required String title,
  required String unit_id,
  required String description,
}) async {
  final uri = Uri.parse('$baseUrl/upload/video');

  try {
    // Step 1: Get upload URL and video ID from your server
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Upload-Length': '$duration',
        'Tus-Resumable': '1.0.0',
        'Accept': 'application/json',
      },
    );

    print('Get upload URL Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to get upload URL: ${response.body}');
    }

    final data = jsonDecode(response.body);

    if (!data.containsKey('upload_url') || !data.containsKey('video_id')) {
      throw Exception('upload_url or video_id missing in response');
    }

    final uploadUrl = data['upload_url'];
    final videoId = data['video_id'];

    print('✅ Successfully received upload URL and video ID');

    // Step 2: Upload video using TUS protocol
    await uploadVideoTUS(
      uploadUrl: uploadUrl,
      videoFile: videoFile,
      token: token,
    );

    // Step 3: Update your database table
    return await table_update(title, description, unit_id, videoId);
  } catch (e) {
    print('❌ Error in video upload: $e');
    rethrow;
  }
}

Future<void> uploadVideoTUS({
  required String uploadUrl,
  required File videoFile,
  required String token,
}) async {
  // Convert File to XFile for TUS client
  final xFile = XFile(videoFile.path);

  // Initialize TUS client with named parameters
  final tusClient = TusClient(
    url: uploadUrl,
    file: xFile,
    chunkSize: 20 * 1024 * 1024, // 20MB chunks
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  try {
    await tusClient.startUpload(
      onProgress: (count, total, response) {
        final percent = (count / total) * 100;
        print('Upload Progress: ${percent.toStringAsFixed(2)}% ($count/$total)');
      },
      onComplete: (response) {
        print('✅ Upload completed successfully!');
        print('Stream URL: ${tusClient.uploadUrl}');
      },
      onError: (error) {
        print('❌ Upload failed: ${error.message}');
        if (error.response != null) {
          print('Server Response: ${error.response!.body}');
        }
        throw Exception('TUS upload failed: ${error.message}');
      },
    );
  } catch (e) {
    print('❌ Unexpected error during upload: $e');
    rethrow;
  }
}

Future<bool> table_update(
  String title,
  String description,
  String unit_id,
  String video_id,
) async {
  final uri = Uri.parse('$baseUrl/unit/videos/update');

  final response = await http.post(
    uri,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode({
      'title': title,
      'description': description,
      'unit_id': unit_id,
      'video_id': video_id,
    }),
  );

  print('Table update Status: ${response.statusCode}');
  print('Table update Response: ${response.body}');

  if (response.statusCode != 200) {
    throw Exception('Table update failed: ${response.body}');
  }

  final Map<String, dynamic> data = jsonDecode(response.body);

  if (data.containsKey('success') && data['success']) {
    return true;
  }

  throw Exception('Table update error: success flag not true');
}

Future<List<Video>> videosGet(String token, String unit_id) async {
  final uri = Uri.parse('$baseUrl/unit/videos?unit_id=$unit_id');

  try {
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Videos API Status: ${response.statusCode}');
    print('Videos API Body: ${response.body}');

    final contentType = response.headers['content-type'];
    if (contentType == null || !contentType.contains('application/json')) {
      throw Exception('Server did not return JSON');
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data.containsKey('videos')) {
        final videosList = data['videos'] as List;
        return videosList
            .map((item) => Video.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('videos key missing in response');
      }
    }

    if (response.statusCode == 401) {
      throw Exception('Unauthorized: Token expired');
    }

    throw Exception('Server error: ${response.statusCode}');
  } catch (e) {
    print('❌ Error in videosGet: $e');
    rethrow;
  }
}