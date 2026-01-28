import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/widgets/customButtonOne.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Custombuttonone(
              text: "AdminUITest",
              onTap: () {
                context.push('/adminnav');
              },
            ),
            SizedBox(height: 20),
            Custombuttonone(
              text: "MentorUITest",
              onTap: () {
                context.push('/mentornavbar');
              },
            ),
            SizedBox(height: 20),
            Custombuttonone(
              text: "StudentUITest",
              onTap: () {
                context.push('/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
