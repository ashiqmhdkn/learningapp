import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:learningapp/admin/admin_pages/admin_subjects.dart';
import 'package:learningapp/admin/admin_widgets/add_course.dart';
import 'package:learningapp/admin/admin_widgets/admin_appbar.dart';
import 'package:learningapp/admin/admin_widgets/course_tile.dart';
import 'package:learningapp/admin/admin_widgets/edit_course.dart';
import 'package:learningapp/providers/courses_provider.dart';

class AdminCourses extends ConsumerWidget {
  const AdminCourses({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(coursesNotifierProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AdminAppBar(
        title: "Courses",
        onAddPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return const AddCourse(); // NO padding here
            },
          );
        },
      ),
      body: coursesAsync.when(
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
                      child: CourseTile(
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
                              builder: (context) => AdminSubjects(
                                courseid: course.course_id as String,
                              ),
                            ),
                          );
                        },
                        onDelete: () {},
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
      ),
    );
  }
}
