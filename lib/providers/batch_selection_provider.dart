import 'package:flutter_riverpod/legacy.dart';

class BatchSelectionNotifier extends StateNotifier<Set<String>> {
  BatchSelectionNotifier() : super({});

  void toggleStudent(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }

  void selectAll(List<String> ids) {
    state = ids.toSet();
  }

  void clearAll() {
    state = {};
  }

  bool isSelected(String id) => state.contains(id);
}

final batchSelectionProvider =
    StateNotifierProvider<BatchSelectionNotifier, Set<String>>(
      (ref) => BatchSelectionNotifier(),
    );
