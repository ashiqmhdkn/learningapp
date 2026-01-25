import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/mentor/mentorWidgets/video_access.dart';
import 'package:learningapp/providers/student_access_provider.dart';
import '../../widgets/customAppBar.dart';

class MentorVideoAccess extends ConsumerWidget {
  final String name;
  MentorVideoAccess({super.key,required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentAccessProvider);

    return Scaffold(
      appBar:  Customappbar(title: name),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: VideoAccess(
              name: student.name,
              isAccessEnabled: student.hasAccess,
              onTap: () {},
              onToggle: (value) {
                ref
                    .read(studentAccessProvider.notifier)
                    .toggleAccess(student.id, value);
              },
            ),
          );
        },
      ),
    );
  }
}
