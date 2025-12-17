import 'subject_model.dart';

class ClassCourse {
  final String className;       // e.g., "Class 9"
  final List<Subject> subjects;

  ClassCourse({
    required this.className,
    required this.subjects,
  });
}
