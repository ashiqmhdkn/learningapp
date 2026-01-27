import 'package:flutter/material.dart';
import 'package:learningapp/widgets/exam_list_tile.dart';

class StudentExams extends StatelessWidget {
  const StudentExams({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 10,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ExamListTile(
              onStartExam: () {},
              title: "Name ${index + 1}",
              subtitle: "Subtitle",
            );
          },
        ),
      ),
    );
  }
}
