import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/api/unitsapi.dart';
import 'package:learningapp/models/unit_model.dart';

final authTokenProvider = Provider<String>((ref) {
  return 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNzJmNjFlYmQtYTM2ZS00YTRmLTgwMjctZGFhZjMxYjg1NWYxIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzcwMjEzODk5fQ.u_z-xly9s-Glkj0WiHANps9uc05eyEu2pWMgPik63mI';
});


class UnitProvider extends AsyncNotifier<List<Unit>> {
  @override
  Future<List<Unit>> build() async {
    state = const AsyncValue.loading();
    final token = ref.watch(authTokenProvider);
    return unitsget(token);
  }
String subject_id="";
void setsubject_id(String subject){
subject_id=subject;
}
  // Create new unit
  Future<bool> createUnit({
    required String title,
    required String unitImage,
  }) async {
    final token = ref.read(authTokenProvider);
    
    try {
      final success = await unitspost(
        token: token,
        title: title,
        subject_id:subject_id,
        unitImage: unitImage,
      );
      
      if (success) {
        // Refresh the list only if the operation was successful
        state = await AsyncValue.guard(() => unitsget(token));
      }
      
      return success;
    } catch (e) {
      // Handle error and return false
      return false;
    }
  }

  // Update existing unit
  Future<bool> updateUnit({
    required String unitId,
    required String title,
    required String? unitImage,
  }) async {
    final token = ref.read(authTokenProvider);
    
    try {
      final success = await unitsPut(
        token: token,
        unit_id: unitId,
        title: title,
        unitImage: unitImage,
      );
      
      if (success) {
        state = const AsyncValue.loading();
        state = await AsyncValue.guard(() => unitsget(token));
      }
      
      return success;
    } catch (e) {
      return false;
    }
  }

  // Delete unit
  Future<bool> deleteUnit({
    required String unitId,
  }) async {
    final token = ref.read(authTokenProvider);
    
    try {
      final success = await unitsDelete(
        token: token,
        unitId: unitId,
      );
      
      if (success) {
        state = const AsyncValue.loading();
        state = await AsyncValue.guard(() => unitsget(token));
      }
      
      return success;
    } catch (e) {
      return false;
    }
  }

  // Refresh units list
  Future<void> refresh() async {
    final token = ref.read(authTokenProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => unitsget(token));
  }
}

final unitsNotifierProvider = 
  AsyncNotifierProvider<UnitProvider, List<Unit>>(
    () => UnitProvider(),
  );