import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/providers/unit_provider.dart';

class UnitPage extends ConsumerWidget {
  final String className;
  final String subjectTitle;

  const UnitPage({
    required this.className,
    required this.subjectTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final units = ref.watch(unitsProvider((className, subjectTitle)));

    return Scaffold(
      appBar: AppBar(title: Text('$subjectTitle'),),
      body: GridView.builder(
        itemCount: units.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final unit = units[index];

          return Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.menu_book, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(unit.title),
                  Text('${unit.videos.length} topics'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
