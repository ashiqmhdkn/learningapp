import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/api/loginapi.dart';

class AuthController extends Notifier<String?> {
  @override
  String? build() => null;

  Future<void> login(String email, String password) async {
    state = "loading";
    try {
      final token = await loginAPI(email, password);
      state = token;
    } catch (e) {
      state = null;
      rethrow;
    }
  }
}
