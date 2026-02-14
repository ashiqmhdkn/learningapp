import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/pages/student_exams.dart';
import 'package:learningapp/providers/batch_provider.dart';
import 'package:learningapp/widgets/edit_unit_card.dart';

class Adminbatch extends ConsumerStatefulWidget {
  final String courseId;
  final String courseName;

  const Adminbatch({
    super.key,
    required this.courseId,
    required this.courseName,
  });

  @override
  ConsumerState<Adminbatch> createState() => _AdminbatchState();
}

class _AdminbatchState extends ConsumerState<Adminbatch> {
  int _selectedIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    Future.microtask(() {
      ref.read(batchsNotifierProvider.notifier).setcourse_id(widget.courseId);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          widget.courseName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.primary,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // showModalBottomSheet(
              //   context: context,
              //   isScrollControlled: true,
              //   showDragHandle: true,
              //   builder: (context) => AddBatch(),
              // );
            },
          ),
        ],),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(60),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        //     child: CustomSlidingSegmentedControl<int>(
        //       initialValue: _selectedIndex,
        //       children: const {0: Text("Batchs"), 1: Text("Exams")},
        //       decoration: BoxDecoration(
        //         color: colorScheme.surface,
        //         borderRadius: BorderRadius.circular(15),
        //         border: Border.all(color: Colors.black12),
        //       ),
        //       thumbDecoration: BoxDecoration(
        //         color: colorScheme.primary,
        //         borderRadius: BorderRadius.circular(15),
        //       ),
        //       onValueChanged: (value) {
        //         setState(() => _selectedIndex = value);
        //         _pageController.animateToPage(
        //           value,
        //           duration: const Duration(milliseconds: 300),
        //           curve: Curves.easeOut,
        //         );
        //       },
        //     ),
        //   ),
        // ),
      // ),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: [_buildBatchsGrid(), const StudentExams()],
      ),
    );
  }

  Widget _buildBatchsGrid() {
    final batchsAsync = ref.watch(batchsNotifierProvider);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: batchsAsync.when(
        data: (batchs) {
          if (batchs.isEmpty) {
            return const Center(child: Text('No batchs available'));
          }

          return AnimationLimiter(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: batchs.length,
              itemBuilder: (context, index) {
                final batch = batchs[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: 2,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50,
                    child: FadeInAnimation(
                      child: EditUnitCard(
                        title: batch.name,
                        image: batch.batchImage,
                         onDelete: () async {
                          final confirm = await showModalBottomSheet<bool>(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Delete Batch?",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    const Text("This action cannot be undone."),

                                    const SizedBox(height: 20),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text("Cancel"),
                                          ),
                                        ),

                                        const SizedBox(width: 10),

                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text("Delete"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );

                          if (confirm == true) {
                            await ref
                                .read(batchsNotifierProvider.notifier)
                                .deleteBatch(batchId: batch.batchId);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Batch deleted")),
                            );
                          }
                        },
                        onEdit: () {
                          // showModalBottomSheet(
                          //   context: context,
                          //   isScrollControlled: true,
                          //   showDragHandle: true,
                          //   builder: (context) => EditBatch(batch: batch),
                          // );
                        },
                        onTap: () {
                          // Navigate to lessons page
                          // context.push('/adminbatchs/${batch.name}',extra: batch.batch_id);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error: $error',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(batchsNotifierProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
