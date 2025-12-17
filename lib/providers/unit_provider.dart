import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/data.dart';
import '../models/unit_model.dart';

final unitsProvider = Provider.family<List<Unit>, (String, String)>(
  (ref, params) {
    final className = params.$1;
    final subjectTitle = params.$2;

    // find class
    final classData = courses.firstWhere(
      (c) => c.className == className,
      orElse: () => throw Exception("Class not found"),
    );

    // find subject
    final subjectData = classData.subjects.firstWhere(
      (s) => s.title == subjectTitle,
      orElse: () => throw Exception("Subject not found"),
    );

    return subjectData.units;
  },
);
