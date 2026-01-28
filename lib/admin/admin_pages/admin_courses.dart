import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/admin/admin_widgets/course_tile.dart';
import 'package:learningapp/widgets/customAppBar.dart';

class AdminCourses extends StatelessWidget {
  const AdminCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push("/newbatchcreation");
        },
        icon: const Icon(Icons.add),
        label: const Text("New Course"),
      ),
      appBar: Customappbar(title: "Courses"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CourseTile(
              onTap: () {
                context.push('/subjects/Class 9');
              },
              title: 'Class 9 ',
              backGroundImage: 'lib/assets/image.png',
            ),
            CourseTile(
              onTap: () {
                context.push('/subjects/Class 10');
              },
              title: 'Class 10 ',
              backGroundImage: 'lib/assets/image.png',
            ),
            CourseTile(
              onTap: () {
                context.push('/subjects/Class 11');
              },
              title: 'Class 11 ',
              backGroundImage: 'lib/assets/image.png',
            ),
            CourseTile(
              onTap: () {
                context.push('/subjects/Class 12');
              },
              title: 'Class 12 ',
              backGroundImage: 'lib/assets/image.png',
            ),
          ],
        ),
      ),
    );
  }
}
