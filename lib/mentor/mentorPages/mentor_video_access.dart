import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:learningapp/mentor/mentorWidgets/video_access.dart';
import 'package:learningapp/providers/student_access_provider.dart';
import '../../widgets/customAppBar.dart';

class MentorVideoAccess extends ConsumerWidget {
  final String name;
  const MentorVideoAccess({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentAccessProvider);

    return Scaffold(
      appBar: Customappbar(title: name),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 400),
                  child: FadeInAnimation(
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
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
