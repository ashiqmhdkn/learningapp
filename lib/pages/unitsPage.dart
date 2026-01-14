import 'package:flutter/material.dart';
import 'package:learningapp/pages/profilePage.dart';
import 'package:learningapp/pages/settingsPage.dart';
import 'package:learningapp/pages/subjectWiseVideos.dart';

class Unitspage extends StatelessWidget {
  final String unitName;
  const Unitspage({super.key, required this.unitName});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text(unitName, style: TextStyle(fontWeight: FontWeight.bold)),
          bottom: TabBar(
            tabs: [
              Tab(text: "Classes"),
              Tab(text: "Exam"),
              Tab(text: "Notes"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Subjectwisevideos(unitName: "Maths"),
            SettingsPage(),
            Profilepage(),
          ],
        ),
      ),
    );
  }
}
