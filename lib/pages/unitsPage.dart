import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
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
          bottom: ButtonsTabBar(
            height: 48,
            radius: 24,
            borderWidth: 1,

            contentPadding: const EdgeInsets.symmetric(horizontal: 18),
            buttonMargin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),

            backgroundColor: Theme.of(context).colorScheme.primary,
            borderColor: Colors.black,
            unselectedBorderColor: Colors.black12,

            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),

            tabs: const [
              Tab(text: "Classes"),
              Tab(text: "Exam"),
              Tab(text: "Notes"),
            ],
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            Subjectwisevideos(unitName: "Maths"),
            Placeholder(),
            Placeholder(),
          ],
        ),
      ),
    );
  }
}
