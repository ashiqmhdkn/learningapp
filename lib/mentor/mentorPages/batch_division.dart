import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/mentor/mentorWidgets/batch_tile.dart';
import 'package:learningapp/widgets/customAppBar.dart';

class BatchDivision extends StatelessWidget {
  const BatchDivision({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(title: "Batches"),

      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 7,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: BatchTile(
              name: "Batch ${index + 1}",
              onTap: () {
                context.push("/mentorvideoaccess/Batch ${index + 1}");
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push("/newbatchcreation");
        },
        icon: const Icon(Icons.add),
        label: const Text("New Batch"),
      ),
    );
  }
}
