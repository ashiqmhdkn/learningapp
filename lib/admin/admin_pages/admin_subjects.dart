import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/admin/admin_widgets/add_subject.dart';
import 'package:learningapp/admin/admin_widgets/admin_appbar.dart';
import 'package:learningapp/admin/admin_widgets/course_tile.dart';
import 'package:learningapp/admin/admin_widgets/edit_subject.dart';
import 'package:learningapp/providers/subject_provider.dart';

class AdminSubjects extends ConsumerStatefulWidget {
  final String courseid;
  const AdminSubjects({super.key, required this.courseid});

  @override
  ConsumerState<AdminSubjects> createState() => _AdminSubjectsState();
}

class _AdminSubjectsState extends ConsumerState<AdminSubjects> {
  @override
  void initState() {
    super.initState();
    // Set courseId only once when widget is created
    Future.microtask(() {
      ref.read(subjectsNotifierProvider.notifier).setcourse_id(widget.courseid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final subjectsState = ref.watch(subjectsNotifierProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AdminAppBar(
        title: "Subjects",
        onAddPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            builder: (context) => const AddSubject(),
          );
        },
      ),
      appBar: Customappbar(title: "Subjects"),
      body: subjectsState.when(
        data: (subjects) { 
           if (subjects.isEmpty) {
            return const Center(child: Text('No Subjects available'));
          }
          return ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return CourseTile(
              onDelete: () {},
              onDelete: () {},
              onEdit: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  showDragHandle: true,
                  builder: (context) => EditSubject(subject: subject),
                );
              },
              title: subject.title,
              backGroundImage: subject.subject_image,
              onTap: () {
                context.push(
                  '/chapterupdate/${subject.title}',
                  extra: subject.subject_id,
                );
                context.push(
                  '/chapterupdate/${subject.title}',
                  extra: subject.subject_id,
                );
              },
            );
          },
        );},
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
