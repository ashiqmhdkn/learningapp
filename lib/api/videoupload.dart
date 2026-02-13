import 'dart:convert';
import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:http/http.dart' as http;
import 'package:tusc/tusc.dart';
import 'package:learningapp/models/video_model.dart';

const String baseUrl = 'https://api.crescentlearning.org';

Future<bool> videoUpload({
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
        'Upload-Length': videoFile.lengthSync().toString(),
        'Tus-Resumable': '1.0.0',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "title": title,
        "description":description,
        "unit_id":unit_id,
      }),
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

    // Step 2: Upload video using TUSC (TUS protocol)
   await uploadVideoTUSC(
      uploadUrl: uploadUrl,
      videoFile: videoFile,
      token: token,
    );
    return true;
    // Step 3: Update your database table
  } catch (e) {
    print('❌ Error in video upload: $e');
    rethrow;
  }
}

Future<void> uploadVideoTUSC({
  required String uploadUrl,
  required File videoFile,
  required String token,
}) async {
  try {
    // Initialize TUSC client
    final client = TusClient(
      url:uploadUrl,
      file:XFile(videoFile.path),
        chunkSize: 20 * 1024 * 1024, // Use memory store for upload state
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print('Starting TUS upload...');
    
    // Start upload with progress tracking
    await  client.startUpload(
      onProgress: (count, total, response) {
        final percent = (count / total) * 100;
        print('Upload Progress: ${percent.toStringAsFixed(2)}% ($count/$total)');
      },
      onComplete: (response) {
        print('✅ Upload completed successfully!');
        print('Stream URL: ${client.uploadUrl}');
      },
      onError: (error) {
        print('❌ Upload failed: ${error.message}'
      );
        if (error.response != null) {
          print('Server Response: ${error.response!.body}');
        }
        throw Exception('TUS upload failed: ${error.message}');
      },
    );
    
  } catch (e) {
    print('❌ Upload failed: $e');
    rethrow;
  }
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