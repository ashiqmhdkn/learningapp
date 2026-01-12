import 'package:flutter/material.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CourseSection(
              title: "Class 9",
              subjects: [
                SubjectData("Mathematics", 'lib/assets/maths.jpeg'),
                SubjectData("Physics", 'lib/assets/maths.jpeg'),
              ],
            ),
            CourseSection(
              title: "Class 10",
              subjects: [
                SubjectData("Mathematics", 'lib/assets/maths.jpeg'),
                SubjectData("Biology", 'lib/assets/maths.jpeg'),
              ],
            ),
            CourseSection(
              title: "Class +1",
              subjects: [
                SubjectData("Physics", 'lib/assets/maths.jpeg'),
                SubjectData("Chemistry", 'lib/assets/maths.jpeg'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CourseSection extends StatelessWidget {
  final String title;
  final List<SubjectData> subjects;

  const CourseSection({super.key, required this.title, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 270,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              return PracticeTile2(
                title: subject.title,
                backGroundImage: subject.imagePath,
              );
            },
          ),
        ),
      ],
    );
  }
}

class SubjectData {
  final String title;
  final String imagePath;

  const SubjectData(this.title, this.imagePath);
}
