import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> profileapi(String token) async {

final primaryUrl = 'https://api.crescentlearning.org';
final uri = Uri.parse('$primaryUrl/profile');

final response = await http.get(
  uri,
  headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    'Accept': 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  },
);

  final Map<String, dynamic> data = jsonDecode(response.body);
  try {
    print(data);
    return data['user']['name'];
  } catch (e) {
    print('Error extracting token: $e');
  }

  throw Exception("Token not found in response");
}
