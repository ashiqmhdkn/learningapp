import 'package:flutter/material.dart';
import 'package:learningapp/widgets/customBoldText.dart';

class BatchTile extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const BatchTile({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Card(
        shadowColor: Theme.of(context).colorScheme.secondary,
        color: Theme.of(context).colorScheme.tertiary,
        child: Center(
          child: InkWell(
            onTap: onTap,
            child: ListTile(
              title: Customboldtext(text: name, fontValue: 17),
              trailing: Icon(Icons.arrow_right),
            ),
          ),
        ),
      ),
    );
  }
}
