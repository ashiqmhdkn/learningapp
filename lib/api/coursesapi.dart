import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:learningapp/models/course_model.dart';
import 'package:learningapp/models/user_model.dart';

const String baseUrl = 'https://api.crescentlearning.org';

Future<List<Course>> coursesget(String token) async {
  final uri = Uri.parse('$baseUrl/courses');

  try {
    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    print('Profile API Response: ${response.statusCode}');
    print('Profile API Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('courses')) {
        final coursesList = data['courses'] as List;
        return coursesList
            .map((item) => Course.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('User data not found in response');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token');
    } else {
      final Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['error'] ?? 'Failed to fetch courses');
    }
  } catch (e) {
    print('Error in courses: $e');
    rethrow;
  }
}
Future<String> coursespost({
   required String token,
  required String title,
  required String description,
  required String courseImage,
}
) async {
  final uri = Uri.parse('$baseUrl/courses');

  try {
    final request = http.MultipartRequest('POST', uri)
      ..fields['title'] = title
      ..fields['description'] = description
      ..files.add(await http.MultipartFile.fromPath('course_image',courseImage))
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json';
final streamed = await request.send();
final res = await http.Response.fromStream(streamed);

print("Status: ${res.statusCode}");
print("Body: ${res.body}");

    if (res.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(res.body);

      if (data['success'] == true && data.containsKey('message') && data.containsKey('course_id')) {
        return data['success'] as String;
      } else {
        throw Exception("Upload failed: ${res.body}");
      }
    } else {
      throw Exception("Server error: ${res.statusCode} ${res.reasonPhrase}, Body: ${res.body}");
    }
  } catch (e) {
    throw Exception("File upload error: $e");
  }
}