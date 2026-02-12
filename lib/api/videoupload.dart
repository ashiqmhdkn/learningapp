import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:learningapp/models/video_model.dart';
import 'package:learningapp/teacher/upload.dart';

const String baseUrl = 'https://api.crescentlearning.org';

Future<bool> videoUpload({required String token,required File videoFile,required int duration,required String title,required String unit_id,required String description}) async {
  final uri = Uri.parse('$baseUrl/upload/video');

  try {
    final response = await http.get(
      uri,
      headers: {
        'Upload-Length':'$duration',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    // 🚨 Guard: ensure JSON response
    final contentType = response.headers['content-type'];

    if (contentType == null || !contentType.contains('application/json')) {
      print(token);
      throw Exception('Server did not return JSON');
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data.containsKey('upload_url')&&data.containsKey('video_id')) {
        final url=data['upload_url'];
        final video_id=data['video_id'];
        print("successfull video url and video id getting");
        uploadVideo( url,videoFile);
        return table_update(title, description, unit_id, video_id);
      } else {
        throw Exception('URL key missing in response');
      }
    }

    if (response.statusCode == 401) {
      throw Exception('Unauthorized: Token expired');
    }

    throw Exception('Server error: ${response.statusCode}');
  } catch (e) {
    print('❌ Error in video upload api: $e');
    rethrow;
  }
}
Future<void> uploadVideo(File videoFile,url) async {

  final request = http.MultipartRequest(
    'POST',
    Uri.parse(url),
  );
  request.files.add(
    await http.MultipartFile.fromPath(
      'file',           // MUST be "file"
      videoFile.path,
      contentType: http.MediaType('video', 'mp4'), // optional
    ),
  );

  final response = await request.send();

  if (response.statusCode != 200) {
    throw Exception('Upload failed');
  }
if(response.statusCode==200){
  print("video uploaded successfully");
}}

Future<bool> table_update(String title, String description,String unit_id,String video_id) async {
  final uri = Uri.parse('$baseUrl/unit/videos/update');

  final response = await http.post(
    uri,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode({
      'title': title,
      'description': description,
      'unit_id':unit_id,
      'video_id':video_id,
    }),
  );

  final Map<String, dynamic> data = jsonDecode(response.body);
  print(data);
  if(data.containsKey('success')&&data['success']){return true;}
  throw Exception("Table update have error");
}




Future<List<Video>> videosGet(String token,String unit_id) async {
  final uri = Uri.parse('$baseUrl/unit/videos?unit_id=$unit_id');

  try {
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    print('videos API Status: ${response.statusCode}');
    print('unit/videos ?  API Body: ${response.body}');

    // 🚨 Guard: ensure JSON response
    final contentType = response.headers['content-type'];

    if (contentType == null || !contentType.contains('application/json')) {
      print(token);
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
        throw Exception('User key missing in response');
      }
    }

    if (response.statusCode == 401) {
      throw Exception('Unauthorized: Token expired');
    }

    throw Exception('Server error: ${response.statusCode}');
  } catch (e) {
    print('❌ Error in profileapi: $e');
    rethrow;
  }
}
