import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          ],
        ),
      ),
    );
  }
}
