import 'package:flutter/material.dart';
import 'package:learningapp/pages/settingsPage.dart';

class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const Customappbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) {
                  return SettingsPage();
                },
              ),
            );
          },
          icon: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
