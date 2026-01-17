import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/pages/profilePage.dart';

class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const 
  Customappbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).go('/profile');
          },
          icon: CircleAvatar(
            backgroundImage: AssetImage("lib/assets/image.png"),
          ),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
