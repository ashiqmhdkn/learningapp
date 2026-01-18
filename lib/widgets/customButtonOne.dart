import 'package:flutter/material.dart';

class Custombuttonone extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const Custombuttonone({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 200,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
