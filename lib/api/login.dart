import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

Future<JWT> login(String email, String password) async {
  final uri = Uri.parse('https://api.crescentlearning.org/login');
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    'Accept': 'application/json',
  };
  final body = jsonEncode({
    'email': email,
    'password': password,
  });

  final response = await http
      .post(uri, headers: headers, body: body)
      .timeout(const Duration(seconds: 15));

  if (response.statusCode >= 200 && response.statusCode < 300) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    // Common token field names: token, access_token, jwt
    final token = data['token'] ?? data['access_token'] ?? data['jwt'];
    if (token is String && token.isNotEmpty) {
      try {
        // Decode JWT (without verification)
        final jwt = JWT.verify(token, SecretKey('your-secret-key')); 
        // If you don’t have the secret, you can just decode:
        // final jwt = JWT.decode(token);

        print('JWT payload: ${jwt.payload}');
        return jwt;
      } catch (e) {
        throw Exception('Invalid JWT: $e');
      }
    }
    throw Exception('Login succeeded but token not found in response.');
  } else {
    String message = 'Login failed: ${response.statusCode}';
    try {
      final Map<String, dynamic> err = jsonDecode(response.body);
      if (err.containsKey('message')) message = '${err['message']}';
      else if (err.containsKey('error')) message = '${err['error']}';
    } catch (_) {}
    throw Exception(message);
  }
}