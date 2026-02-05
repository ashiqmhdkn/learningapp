import 'package:flutter/material.dart';

class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      duration: duration,
      backgroundColor: backgroundColor ?? Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
