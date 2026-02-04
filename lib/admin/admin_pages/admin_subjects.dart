import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/admin/admin_widgets/add_course.dart';
import 'package:learningapp/admin/admin_widgets/course_tile.dart';
import 'package:learningapp/admin/admin_widgets/edit_course.dart';
import 'package:learningapp/providers/courses_provider.dart';
import 'package:learningapp/providers/subject_provider.dart';
import 'package:learningapp/widgets/customAppBar.dart';

class AdminSubjects extends ConsumerWidget {
  final String courseid;
 AdminSubjects({super.key ,required this.courseid});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Subjectsread= ref.watch(subjectsNotifierProvider);
    ref.read(subjectsNotifierProvider.notifier).setcourse_id(courseid);
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
      appBar: Customappbar(title: "Subjects"),
      body: Subjectsread.when(
        data: (subjects) => ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return CourseTile(
              onEdit: () {},
              title: subject.title,
              backGroundImage: subject.subject_image,
              onTap: () => print("Tapped ${subject.title}"),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
