import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Studentinfotile extends StatelessWidget {
  final String name;
  final double progress;
  final int flag;
  const Studentinfotile({
    super.key,
    required this.name,
    required this.progress,
    required this.flag,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Card(
        shadowColor: Theme.of(context).colorScheme.secondary,
        color: Theme.of(context).colorScheme.tertiary,
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("lib/assets/image.png"),
            ),
            title: Text(name),
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
                  flag == 0
                      ? Text(
                          "${(progress).toInt()}%",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text("${progress.toInt()}/\n100"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
