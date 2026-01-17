import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/api/login.dart';

class AuthController extends Notifier<String?> {
  @override
  String? build() => null;

  Future<void> login(String email, String password) async {
    state = "loading";
    try {
      final token = await loginApi(email, password);
      state = token;
    } catch (e) {
      state = null;
      rethrow;
    }
  }
}

final authControllerProvider =
    NotifierProvider<AuthController, String?>(() => AuthController());
