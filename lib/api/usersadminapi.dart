import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:learningapp/models/user_model.dart';

const String baseUrl = 'https://api.crescentlearning.org';

Future<List<User>> usersforadmin(String token) async {
  final uri = Uri.parse('$baseUrl/admin/users');

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
      if (data.containsKey('users')) {
        return (data['users'] as List).map((user) => User.fromJson(user)).toList();
      } else {
        throw Exception('User data not found in response');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token');
    } else {
      final Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['error'] ?? 'Failed to fetch users');
    }
  } catch (e) {
    print('Error in usersforadmin: $e');
    rethrow;
  }
}
