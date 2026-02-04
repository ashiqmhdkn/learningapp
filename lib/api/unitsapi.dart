import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:learningapp/models/unit_model.dart';

const String baseUrl = 'https://api.crescentlearning.org';

// GET - Fetch all units
Future<List<Unit>> unitsget(String token) async {
  final uri = Uri.parse('$baseUrl/units');
  try {
    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    
    print('GET units Response: ${response.statusCode}');
    print('GET units Body: ${response.body}');
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('units')) {
        final unitsList = data['units'] as List;
        return unitsList
            .map((item) => Unit.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('units data not found in response');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token');
    } else {
      final Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['error'] ?? 'Failed to fetch units');
    }
  } catch (e) {
    print('Error in unitsget: $e');
    rethrow;
  }
}

// POST - Create new unit
Future<bool> unitspost({
  required String token,
  required String title,
  required String subject_id,
  required String unitImage,
}) async {
  final uri = Uri.parse('$baseUrl/units');
  try {
    final request = http.MultipartRequest('POST', uri)
      ..fields['title'] = title
      ..fields['subject_id'] = subject_id
      ..files.add(await http.MultipartFile.fromPath('unit_image', unitImage))
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json';

    final streamed = await request.send();
    final res = await http.Response.fromStream(streamed);
    
    print("POST Status: ${res.statusCode}");
    print("POST Body: ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(res.body);
      return data['success'] == true;
    } else {
      print("Server error: ${res.statusCode} ${res.reasonPhrase}, Body: ${res.body}");
      return false;
    }
  } catch (e) {
    print('Error in unitspost: $e');
    return false;
  }
}

// PUT - Update existing unit
Future<bool> unitsPut({
  required String token,
  required String title,
  required String unit_id,
  String? unitImage,
}) async {
  final uri = Uri.parse('$baseUrl/units');
  try {
    final request = http.MultipartRequest('PUT', uri)
      ..fields['title'] = title
      ..fields['unit_id'] = unit_id
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json';

    // Only add image if provided
    if (unitImage != null && unitImage.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('unit_image', unitImage)
      );
    }

    final streamed = await request.send();
    final res = await http.Response.fromStream(streamed);
    
    print("PUT Status: ${res.statusCode}");
    print("PUT Body: ${res.body}");

    if (res.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(res.body);
      return data['success'] == true;
    } else {
      print("Server error: ${res.statusCode}, Body: ${res.body}");
      return false;
    }
  } catch (e) {
    print('Error in unitsPut: $e');
    return false;
  }
}

// DELETE - Delete unit
Future<bool> unitsDelete({
  required String token,
  required String unitId,
}) async {
  final uri = Uri.parse('$baseUrl/units/$unitId');
  try {
    final request = http.Request('DELETE', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json'
      ..headers['Content-Type'] = 'application/json';

    final streamed = await request.send();
    final res = await http.Response.fromStream(streamed);
    
    print("DELETE Status: ${res.statusCode}");
    print("DELETE Body: ${res.body}");

    if (res.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(res.body);
      return data['success'] == true;
    } else if (res.statusCode == 404) {
      print("Course not found");
      return false;
    } else {
      print("Server error: ${res.statusCode}, Body: ${res.body}");
      return false;
    }
  } catch (e) {
    print('Error in unitsDelete: $e');
    return false;
  }
}