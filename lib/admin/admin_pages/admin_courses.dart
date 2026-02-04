import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/admin/admin_pages/admin_subjects.dart';
import 'package:learningapp/admin/admin_widgets/add_course.dart';
import 'package:learningapp/admin/admin_widgets/course_tile.dart';
import 'package:learningapp/admin/admin_widgets/edit_course.dart';
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
              onEdit: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => EditCourse(course: course),
                );
              },
              title: course.title,
              backGroundImage: course.course_image,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AdminSubjects(courseid: course.course_id as String),
                  ),
                );
              },
              onDelete: () {},
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
