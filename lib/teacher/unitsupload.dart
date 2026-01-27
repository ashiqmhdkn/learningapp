import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/pages/student_exams.dart';
import 'package:learningapp/pages/subjectWiseVideos.dart';
import './providers/unitcontroller.dart';

class Unitsupload extends ConsumerWidget {
  final String unitName;
  const Unitsupload({super.key, required this.unitName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(unitsControllerProvider);
    final controller = ref.read(unitsControllerProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          unitName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          CircleAvatar(
            radius: 24,
            backgroundColor: colorScheme.primary,
            child: IconButton(
              iconSize: 24,
              onPressed: () {
                context.push('/upload');
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomSlidingSegmentedControl<int>(
              initialValue: selectedIndex,
              children: const {
                0: Text("Classes"),
                1: Text("Exams"),
                2: Text("Notes"),
              },
              decoration: BoxDecoration(
                color: colorScheme.surface,
                // borderRadius: BorderRadius.circular(15),
                // border: Border.all(color: Colors.black12),
              ),
              thumbDecoration: BoxDecoration(
                color: colorScheme.primary,

                borderRadius: BorderRadius.circular(15),
              ),
              onValueChanged: controller.setIndex,
            ),
          ),
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: controller.pageChanged,
        children: [
          Subjectwisevideos(unitName: unitName),
          StudentExams(),
          const Placeholder(),
        ],
      ),
    );
  }
}
