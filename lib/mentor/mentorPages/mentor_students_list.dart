import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/mentor/mentorWidgets/student_info_tile.dart';
import 'package:learningapp/widgets/customAppBar.dart';

class MentorStudentsList extends StatelessWidget {
  const MentorStudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Customappbar(title: "Students"),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),

        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Studentinfotile(
              onTap: () {
                context.push("/mentorStudentIndividual/Name ${index + 1}");
              },
              name: "Name ${index + 1}",
              progress: (index + 58),
              flag: 0,
            ),
          );
        },
      ),
    );
  }
}
