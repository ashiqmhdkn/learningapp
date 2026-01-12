import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/pages/settingsPage.dart';
import 'package:learningapp/providers/subject_provider.dart';
import 'package:learningapp/widgets/mainPage.dart';
import 'package:learningapp/widgets/subject_tittle.dart';

class SubjectPage extends ConsumerWidget {
  const SubjectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectItems = ref.watch(subjectsProvider('Class 9'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 38, 0, 255),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Top container
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 38, 0, 255),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
            ),
            child: const Center(
              child: Text(
                "Class 9 Subjects",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Bottom grid
          Expanded(
            child: subjectItems.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.9,
                        ),
                    itemCount: subjectItems.length, // ✅ FIXED
                    itemBuilder: (context, index) {
                      final subject = subjectItems[index];
                      return SubjectTile(subject: subject);
                    },
                  ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    return Mainpage();
                  },
                ),
              );
            },
            child: Text("Test"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    return SettingsPage();
                  },
                ),
              );
            },
            child: Text("Settings"),
          ),
        ],
      ),
    );
  }
}
