import 'package:flutter/material.dart';
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
            Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('lib/assets/image.png'),
                        ),
                        SizedBox(width: 60),
                        Column(
                          children: [
                            Customprimarytext(text: "Name", fontValue: 25),
                            Customprimarytext(text: "Class XII", fontValue: 15),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Handlscorecontainer(
                  text: "Highest Score",
                  mark: 99,
                  subject: "Computer",
                ),
                SizedBox(width: 40),
                Handlscorecontainer(
                  text: "Lowest Score",
                  mark: 20,
                  subject: "Chemistry",
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(height: 150, width: double.infinity, child: Streak()),
            Coursecompletionpiechart(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
