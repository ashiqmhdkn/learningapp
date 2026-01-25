import 'package:flutter/material.dart';

class VideoAccess extends StatelessWidget {
  final String name;
  final bool isAccessEnabled;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggle;

  const VideoAccess({
    super.key,
    required this.name,
    required this.isAccessEnabled,
    required this.onTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Card(
        shadowColor: Theme.of(context).colorScheme.secondary,
        color: Theme.of(context).colorScheme.tertiary,
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            leading: const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("lib/assets/image.png"),
            ),
            title: Text(name),
            subtitle: Text(
              isAccessEnabled ? "Access Granted" : "Access Revoked",
              style: TextStyle(
                color: isAccessEnabled ? Colors.green : Colors.red,
                fontSize: 12,
              ),
            ),
            trailing: Switch(
              value: isAccessEnabled,
              onChanged: onToggle,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
