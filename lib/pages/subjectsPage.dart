import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/widgets/customAppBar.dart';
import 'package:learningapp/widgets/practiceTIle2.dart';

class Subjectspage extends StatelessWidget {
  final String courseName;

  const Subjectspage({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> practiceList = [
      {"title": "Maths", "image": 'lib/assets/maths.jpeg'},
      {"title": "Physics", "image": 'lib/assets/physics.jpeg'},
      {"title": "biology", "image": 'lib/assets/biology.jpeg'},
      {"title": "Maths", "image": 'lib/assets/maths.jpeg'},
    ];
    return Scaffold(
      appBar: Customappbar(title: courseName),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: practiceList.length,
        itemBuilder: (context, index) {
          final item = practiceList[index];

          return PracticeTile2(
            title: item["title"]!,
            backGroundImage: item["image"]!,
            onTap: () {
              context.push('/chapters/${item['title']}');
            },
          );
        },
      ),
    );
  }
}
