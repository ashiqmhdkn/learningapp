import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/mentor/mentorWidgets/student_info_tile.dart';
import 'package:learningapp/models/student_model.dart';
import 'package:learningapp/widgets/customAppBar.dart';

class MentorStudentsList extends StatelessWidget {
  const MentorStudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Student> students = List.generate(
      20,
      (index) => Student(
        id: "stu_${index + 1}",
        name: "Name ${index + 1}",
        progress: 58 + index,
        hasAccess: index.isEven,
      ),
    );

    return Scaffold(
      appBar: const Customappbar(title: "Students"),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Studentinfotile(
              name: student.name,
              progress: student.progress.toDouble(),
              flag: 0,
              onTap: () {
                context.push(
                  "/mentorStudentIndividual/${student.name}",
                  extra: student,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
