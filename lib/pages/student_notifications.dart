import 'package:flutter/material.dart';
import 'package:learningapp/widgets/customAppBar.dart';

class StudentNotifications extends StatelessWidget {
  const StudentNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(title: "Messages"),
      body: Center(child: Text("No new Messages")),
    );
  }
}
