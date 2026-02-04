import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/api/coursesapi.dart';
import 'package:learningapp/models/course_model.dart';

final authTokenProvider = Provider<String>((ref) {
  return 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNzJmNjFlYmQtYTM2ZS00YTRmLTgwMjctZGFhZjMxYjg1NWYxIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzcwMjEzODk5fQ.u_z-xly9s-Glkj0WiHANps9uc05eyEu2pWMgPik63mI';
});

class CoursesNotifier extends AsyncNotifier<List<Course>> {
  @override
  Future<List<Course>> build() async {
    state = const AsyncValue.loading();
    final token = ref.watch(authTokenProvider);
    return coursesget(token);
  }

  // Create new course
  Future<bool> createCourse({
    required String title,
    required String description,
    required String courseImage,
  }) async {
    final token = ref.read(authTokenProvider);
    
    try {
      final success = await coursespost(
        token: token,
        title: title,
        description: description,
        courseImage: courseImage,
      );
      
      if (success) {
        // Refresh the list only if the operation was successful
        state = await AsyncValue.guard(() => coursesget(token));
      }
      
      return success;
    } catch (e) {
      // Handle error and return false
      return false;
    }
  }

  // Update existing course
  Future<bool> updateCourse({
    required String courseId,
    required String title,
    required String description,
    String? courseImage,
  }) async {
    final token = ref.read(authTokenProvider);
    
    try {
      final success = await coursesPut(
        token: token,
        courseId: courseId,
        title: title,
        description: description,
        courseImage: courseImage,
      );
      
      if (success) {
        state = const AsyncValue.loading();
        state = await AsyncValue.guard(() => coursesget(token));
      }
      
      return success;
    } catch (e) {
      return false;
    }
  }

  // Delete course
  Future<bool> deleteCourse({
    required String courseId,
  }) async {
    final token = ref.read(authTokenProvider);
    
    try {
      final success = await coursesDelete(
        token: token,
        courseId: courseId,
      );
      
      if (success) {
        state = const AsyncValue.loading();
        state = await AsyncValue.guard(() => coursesget(token));
      }
      
      return success;
    } catch (e) {
      return false;
    }
  }

  // Refresh courses list
  Future<void> refresh() async {
    final token = ref.read(authTokenProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => coursesget(token));
  }
}

final coursesNotifierProvider = 
  AsyncNotifierProvider<CoursesNotifier, List<Course>>(
    () => CoursesNotifier(),
  );