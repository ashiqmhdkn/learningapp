import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'dart:io';

class AuthController extends Notifier<String?> {
  @override
  String? build() => null;

  Future<void> loginAPI(String email, String password) async {
    final primaryUrl = dotenv.env['PRIMARY_URL'];
    if (primaryUrl == null) {
      throw Exception('PRIMARY_URL not found in .env file');
    }

    final uri = Uri.parse(primaryUrl).replace(path: '/login');

    final response = await http.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    final token = data['token'];
    if (token is String && token.isNotEmpty) {
      state = token; // store token in state
      return;
    }

    throw Exception('Token not found');
  }
}

final authControllerProvider = NotifierProvider<AuthController, String?>(
  () => AuthController(),
);