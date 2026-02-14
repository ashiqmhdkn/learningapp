import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:learningapp/admin/admin_pages/admin_batch.dart';
import 'package:learningapp/models/Course_model.dart';
import 'package:learningapp/providers/courses_provider.dart';
import 'package:learningapp/widgets/coursecard.dart';

class BatchCourseview extends ConsumerStatefulWidget {
  const BatchCourseview({super.key});
  ConsumerState<BatchCourseview> createState() => _BatchCourseViewState();
}

class _BatchCourseViewState extends ConsumerState<BatchCourseview> {
  @override
  Widget build(BuildContext context) {
    final coursesState = ref.watch(coursesNotifierProvider);
    return coursesState.when(
      data: (courses) {
        if (courses.isEmpty) {
          return const Center(child: Text("No Coures Available"));
        }
        return AnimationLimiter(
          child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 400),
                  child: FadeInAnimation(
                    child: Coursecard1(
                      course: Course(
                        course_image: course.course_image,
                        title: course.title,
                        description: course.description,
                      ),
                      OTap: () {
                        print("Tapped: ${course.course_id}");

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => Adminbatch(
                              courseId: course.course_id!,
                              courseName: course.title,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
