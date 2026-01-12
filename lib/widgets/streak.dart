import 'package:flutter/material.dart';
import 'package:streakify/streakify.dart';

class Streak extends StatelessWidget {
  const Streak({super.key});

  @override
  Widget build(BuildContext context) {
    return StreakifyWidget(
      borderColor: Colors.grey,
      numberOfDays: 30,
      isDayTargetReachedMap: {
        1: true,
        2: true,
        3: false,
        4: true,
        5: true,
        6: true,
        7: false,
        8: true,
        9: true,
        10: false,
        11: true,
        12: true,
        13: true,
        14: true,
        15: false,
      },
    );
  }
}
