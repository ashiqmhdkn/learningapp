import 'package:flutter/material.dart';
import 'package:learningapp/widgets/calender.dart';
import 'package:learningapp/widgets/courseCompletionPieChart.dart';
import 'package:learningapp/widgets/customPrimaryText.dart';
import 'package:learningapp/widgets/darkOrLight.dart';
import 'package:learningapp/widgets/hAndLScoreContainer.dart';
import 'package:learningapp/widgets/streak.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [Darkorlight()]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('lib/assets/image.png'),
                ),
                const SizedBox(width: 60),
                Column(
                  children: [
                    Customprimarytext(text: "Name", fontValue: 25),
                    Customprimarytext(text: "Class XII", fontValue: 15),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Scores Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Handlscorecontainer(
                  text: "Highest Score",
                  mark: 99,
                  subject: "Computer",
                ),
                const SizedBox(width: 40),
                Handlscorecontainer(
                  text: "Lowest Score",
                  mark: 20,
                  subject: "Chemistry",
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Streak Widget
            SizedBox(height: 150, width: double.infinity, child: Streak()),

            const SizedBox(height: 10),

            // Calendar Widget
            CalendarWidget(
              initialDate: DateTime.now(),
              onDateSelected: (date) {
                print('Selected date: $date');
              },
            ),

            const SizedBox(height: 10),

            // Course Completion Chart
            Coursecompletionpiechart(),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
