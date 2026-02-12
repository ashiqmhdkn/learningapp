import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/models/course_info_model.dart';
import 'package:learningapp/pages/course_info_page.dart';
import 'package:learningapp/widgets/course_card_new.dart';
import 'package:learningapp/widgets/customAppBar.dart';
import 'package:learningapp/widgets/practiceTIle2.dart';

class CourseSubjectPage extends StatelessWidget {
  const CourseSubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: Customappbar(title: "Username"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PracticeTile2(
              onTap: () {
                context.push('/subjects/Class 9');
              },
              title: 'Class 9 ',
              backGroundImage: 'lib/assets/image.png',
            ),
            PracticeTile2(
              onTap: () {
                context.push('/subjects/Class 10');
              },
              title: 'Class 10 ',
              backGroundImage: 'lib/assets/image.png',
            ),
            PracticeTile2(
              onTap: () {
                context.push('/subjects/Class 11');
              },
              title: 'Class 11 ',
              backGroundImage: 'lib/assets/image.png',
            ),
            PracticeTile2(
              onTap: () {
                context.push('/subjects/Class 12');
              },
              title: 'Class 12 ',
              backGroundImage: 'lib/assets/image.png',
            ),
            CourseCard(
              course: dummyCourse,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return CourseInfoPage(
                        course: dummyCourse,
                        onTap: () {
                          context.push('/subjects/Class 12');
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

final dummyCourse = CourseInfoModel(
  id: "1",
  title: "Class 9",
  subtitle: "Complete Class 9 Syllabus",
  languageTag: "MAL",
  categoryTag: "FULL SYLLABUS BATCH",
  bannerImageUrl:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDIqG_xMwR4FqQCYDVRkqZ9n4C9kfUNA4_Qg&s",
  educators: [
    CourseEducator(id: "1", name: "Ashiq", imageUrl: ""),
    CourseEducator(id: "2", name: "Vishnu", imageUrl: ""),
    CourseEducator(id: "3", name: "Vaishnav", imageUrl: ""),
  ],
  batchStartDate: DateTime(2024, 7, 4),
  enrollmentEndDate: DateTime.now().add(const Duration(days: 323)),
  about: CourseAbout(
    description:
        "This batch is designed specially for State based class 9. Top educators will teach Linear Algebra, Circle, Rectangle and Square.",
    highlights: [
      "Linear Algebra",
      "Maths",
      "Circle",
      "Trigonometry",
      "Integration",
    ],
  ),
  stats: CourseStats(
    liveClasses: 150,
    teachingLanguages: ["English", "Malayalam"],
  ),
  pricing: CoursePricing(price: 12999, currency: "₹", isFree: false),
  isEnrolled: false,
);
