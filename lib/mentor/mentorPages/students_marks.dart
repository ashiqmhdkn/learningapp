import 'package:flutter/material.dart';
import 'package:learningapp/mentor/mentorWidgets/student_info_tile.dart';
import 'package:learningapp/widgets/customAppBar.dart';

class StudentsMarks extends StatelessWidget {
  const StudentsMarks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Customappbar(title: "Marks"),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),

        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Studentinfotile(
              name: "Name ${index + 1}",
              progress: (index + 58),
              flag: 1,
            ),
          );
        },
      ),
    );
  }
}
