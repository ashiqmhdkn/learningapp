import 'package:flutter/material.dart';

class Handlscorecontainer extends StatelessWidget {
  final String text;
  final int mark;
  final String subject;
  const Handlscorecontainer({
    super.key,
    required this.text,
    required this.mark,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 15),
          Text(
            mark.toString(),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: mark > 60 ? Colors.green : Colors.red,
            ),
          ),
          SizedBox(height: 10),
          Text(
            subject,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
