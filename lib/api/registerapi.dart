import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> registerApi(
    String email, String password, String username, String role) async {

  final primaryUrl = dotenv.env['PRIMARY_URL']!;
  final uri = Uri.parse('$primaryUrl/signup');

  final response = await http.post(
    uri,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode({
      'email': email,
      'password': password,
      'name': username,
      'role': role,
    }),
  );

  final Map<String, dynamic> data = jsonDecode(response.body);
  if (data['success']) {
    return 'success';
  }

  throw Exception("Token not found in response");
}
