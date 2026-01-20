import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learningapp/widgets/customBoldText.dart';
import 'package:learningapp/widgets/customPrimaryText.dart';

class ExamInfoTile extends StatelessWidget {
  final String name;
  final double progress;
  const ExamInfoTile({super.key, required this.name, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Card(
        shadowColor: Theme.of(context).colorScheme.secondary,
        color: Theme.of(context).colorScheme.tertiary,
        child: Center(
          child: ListTile(
            title: Customboldtext(text: name, fontValue: 17),
            subtitle: Customprimarytext(text: "Unit", fontValue: 16),
            trailing: SizedBox(
              width: 40,
              height: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 85,
                    width: 85,
                    child: CircularProgressIndicator(
                      color: progress >= 70 ? Colors.green : Colors.red,
                      value: (progress) / 90,
                      strokeWidth: 4,
                    ),
                  ),
                  Text(
                    "${(progress).toInt()}%",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
