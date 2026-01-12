import 'package:flutter/material.dart';
import 'package:learningapp/widgets/customPrimaryText.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('lib/assets/image.png'),
                  ),
                  SizedBox(height: 15),
                  Customprimarytext(text: "Name", fontValue: 25),
                  Customprimarytext(text: "Class XII", fontValue: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
