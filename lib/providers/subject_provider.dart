import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/api/subjectsapi.dart';
import 'package:learningapp/models/subject_model.dart';

final authTokenProvider = Provider<String>((ref) {
  return 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNzJmNjFlYmQtYTM2ZS00YTRmLTgwMjctZGFhZjMxYjg1NWYxIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzcwMjEzODk5fQ.u_z-xly9s-Glkj0WiHANps9uc05eyEu2pWMgPik63mI';
});

class SubjectProvider extends AsyncNotifier<List<Subject>> {
  String course_id = "";

  @override
  Future<List<Subject>> build() async {
    // Don't manually set loading state - AsyncNotifier handles this
    final token = ref.watch(authTokenProvider);
    
    // If course_id is empty, return empty list or throw error
    if (course_id.isEmpty) {
      return [];
    }
    
    return subjectsget(token:token, course_id:course_id);
  }

  void setcourse_id(String course) {
    course_id = course;
    // Trigger a rebuild after setting course_id
    ref.invalidateSelf();
  }

  // Create new subject
  Future<bool> createSubject({
    required String title,
    required String subjectImage,
  }) async {
    final token = ref.read(authTokenProvider);
    
    try {
      final success = await subjectspost(
        token: token,
        title: title,
        course_id: course_id,
        subjectImage: subjectImage,
      );
      
      if (success) {
        // Refresh the list only if the operation was successful
        state = await AsyncValue.guard(() => subjectsget(token:token, course_id:course_id));
      }
      
      return success;
    } catch (e) {
      // Handle error and return false
      return false;
    }
  }

  // Update existing subject
  Future<bool> updateSubject({
    required String subjectId,
    required String title,
    required String? subjectImage,
  }) async {
    final token = ref.read(authTokenProvider);
    
    try {
      final success = await subjectsPut(
        token: token,
        subject_id: subjectId,
        title: title,
        subjectImage: subjectImage,
      );
      
      if (success) {
        state = const AsyncValue.loading();
        state = await AsyncValue.guard(() => subjectsget(token:token, course_id:course_id));
      }
      
      return success;
    } catch (e) {
      return false;
    }
  }

  // Delete subject
  Future<bool> deleteSubject({
    required String subjectId,
  }) async {
    final token = ref.read(authTokenProvider);
    
    try {
      final success = await subjectsDelete(
        token: token,
        subjectId: subjectId,
      );
      
      if (success) {
        state = const AsyncValue.loading();
        state = await AsyncValue.guard(() => subjectsget(token:token, course_id:course_id));
      }
      
      return success;
    } catch (e) {
      return false;
    }
  }

  // Refresh subjects list
  Future<void> refresh() async {
    final token = ref.read(authTokenProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => subjectsget(token:token, course_id:course_id));
  }
}

final subjectsNotifierProvider = 
  AsyncNotifierProvider<SubjectProvider, List<Subject>>(
    () => SubjectProvider(),
  );
