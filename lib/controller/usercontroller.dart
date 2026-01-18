// controller/usercontroller.dart
// Handles ALL user profile operations (fetch, update, delete)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import 'authcontroller.dart';

class UserState {
  final User? user;
  final bool isLoading;
  final String? error;

  UserState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  UserState copyWith({
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class UserController extends StateNotifier<UserState> {
  UserController(this.ref) : super(UserState());

  final Ref ref;
  static const String baseUrl = 'https://api.crescentlearningapp.org';

  // Fetch user profile
  Future<void> fetchProfile() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final token = await ref.read(authControllerProvider.notifier).getToken();
      if (token == null) throw Exception('No token found');

      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user']);
        state = state.copyWith(user: user, isLoading: false);
      } else if (response.statusCode == 401) {
        // Token expired - logout
        await ref.read(authControllerProvider.notifier).logout();
        throw Exception('Session expired. Please login again.');
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to fetch profile');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  // Update user profile
  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? role,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final token = await ref.read(authControllerProvider.notifier).getToken();
      if (token == null) throw Exception('No token found');

      final body = <String, dynamic>{};
      if (name != null) body['name'] = name;
      if (email != null) body['email'] = email;
      if (phone != null) body['phone'] = phone;
      if (role != null) body['role'] = role;

      final response = await http.put(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Refresh profile after update
        await fetchProfile();
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to update profile');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  // Update user with User object
  Future<void> updateProfileWithUser(User updatedUser) async {
    await updateProfile(
      name: updatedUser.username,
      email: updatedUser.email,
      phone: updatedUser.phone.toString(),
      role: updatedUser.role,
    );
  }

  // Delete user account
  Future<void> deleteAccount() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final token = await ref.read(authControllerProvider.notifier).getToken();
      if (token == null) throw Exception('No token found');

      final response = await http.delete(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Logout after successful deletion
        await ref.read(authControllerProvider.notifier).logout();
        state = UserState(); // Reset state
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to delete account');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  // Clear user data (useful for logout)
  void clearUser() {
    state = UserState();
  }
}

// Provider
final userControllerProvider = StateNotifierProvider<UserController, UserState>((ref) {
  return UserController(ref);
});

// Convenience providers
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(userControllerProvider).user;
});

final userLoadingProvider = Provider<bool>((ref) {
  return ref.watch(userControllerProvider).isLoading;
});