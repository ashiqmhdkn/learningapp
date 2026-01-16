import 'package:flutter/material.dart';

class ManageTeachers extends StatelessWidget {
  const ManageTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: 20,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return Column(
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: scheme.tertiary,
              child: Icon(Icons.person_outline, color: scheme.onSurface),
            ),
            const SizedBox(height: 6),
            Text(
              "Name ${index + 1}",
              style: TextStyle(fontSize: 12, color: scheme.onSurface),
            ),
          ],
        );
      },
    );
  }
}
