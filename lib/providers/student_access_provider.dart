import 'package:flutter_riverpod/legacy.dart';
import 'package:learningapp/models/student_model.dart';

class StudentAccessNotifier extends StateNotifier<List<Student>> {
  StudentAccessNotifier()
    : super([
        Student(
          id: "stu_001",
          name: "Student A",
          hasAccess: true,
          progress: 50,
        ),
        Student(
          id: "stu_002",
          name: "Student B",
          hasAccess: false,
          progress: 70,
        ),
        Student(
          id: "stu_003",
          name: "Student C",
          hasAccess: true,
          progress: 80,
        ),
      ]);

  void toggleAccess(String studentId, bool value) {
    state = [
      for (final student in state)
        if (student.id == studentId)
          student.copyWith(hasAccess: value)
        else
          student,
    ];
  }
}

final studentAccessProvider =
    StateNotifierProvider<StudentAccessNotifier, List<Student>>(
      (ref) => StudentAccessNotifier(),
    );
