import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> unitsupload(File file,String unitname,String subject_id,String token) async {
  const primaryUrl = 'https://api.crescentlearning.org';
  final uri = Uri.parse('$primaryUrl/units');

  try {
    final request = http.MultipartRequest('POST', uri)
      ..fields['title'] = unitname
      ..fields['subject_id'] = subject_id
      ..files.add(await http.MultipartFile.fromPath('unit_image', file.path))
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json';
final streamed = await request.send();
final res = await http.Response.fromStream(streamed);

print("Status: ${res.statusCode}");
print("Body: ${res.body}");

    if (res.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(res.body);

      if (data['success'] == true && data.containsKey('message') && data.containsKey('unit_id')) {
        return data['message'] as String;
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