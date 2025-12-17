import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/data.dart';
import '../models/subject_model.dart';

final subjectsProvider =
    Provider.family<List<Subject>, String>((ref, className) {
  final classData = courses.firstWhere(
    (c) => c.className == className,
    orElse: () => throw Exception("Class not found"),
  );

  return classData.subjects;
});
