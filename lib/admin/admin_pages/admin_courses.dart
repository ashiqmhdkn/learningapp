import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/admin/admin_pages/admin_create_course.dart';
import 'package:learningapp/admin/admin_widgets/course_tile.dart';
import 'package:learningapp/api/coursesapi.dart';
import 'package:learningapp/models/course_model.dart';
import 'package:learningapp/widgets/customAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminCourses extends StatelessWidget {
  const AdminCourses({super.key});

  @override
  Widget build(BuildContext context) {
    // final Future<List<Course>> coursesFuture =
    //     coursesget("eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNzJmNjFlYmQtYTM2ZS00YTRmLTgwMjctZGFhZjMxYjg1NWYxIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzcwMjEzODk5fQ.u_z-xly9s-Glkj0WiHANps9uc05eyEu2pWMgPik63mI");

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showBottomSheet(context: context, 
  showDragHandle: true, // safe here
  enableDrag: true,  builder:(context)=> Coursebottomsheet());
        },
        icon: const Icon(Icons.add),
        label: const Text("New Course"),
      ),
      appBar: Customappbar(title: "Courses"),
      body: FutureBuilder<List<dynamic>>(
  future: Future.wait([
    SharedPreferences.getInstance().then((prefs) => prefs.getString('token')),
    coursesget("eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNzJmNjFlYmQtYTM2ZS00YTRmLTgwMjctZGFhZjMxYjg1NWYxIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzcwMjEzODk5fQ.u_z-xly9s-Glkj0WiHANps9uc05eyEu2pWMgPik63mI"),
  ]),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text("Error: ${snapshot.error}"));
    }

    final token = snapshot.data![0] as String?;
    final courses = snapshot.data![1] as List<Course>;

    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return CourseTile(
          title: course.title,
          backGroundImage: course.course_image??" ", 
          onTap: () => print("Tapped ${course.title}"),
        );
      },
    );
  },
      ),);
  }
}
