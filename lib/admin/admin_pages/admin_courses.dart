import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/admin/admin_widgets/add_course.dart';
import 'package:learningapp/admin/admin_widgets/course_tile.dart';
import 'package:learningapp/providers/courses_provider.dart';
import 'package:learningapp/widgets/customAppBar.dart';

class AdminCourses extends ConsumerWidget {
  const AdminCourses({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(coursesNotifierProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showBottomSheet(
            context: context,
            showDragHandle: true, // safe here
            enableDrag: true,
            builder: (context) => AddCourse(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("New Course"),
      ),
      appBar: Customappbar(title: "Courses"),
      body: coursesAsync.when(
        data: (courses) => ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return CourseTile(
              title: course.title,
              backGroundImage: course.course_image,
              onTap: () => print("Tapped ${course.title}"),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
