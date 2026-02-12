import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/pages/student_exams.dart';
import 'package:learningapp/providers/unit_provider.dart';
import 'package:learningapp/teacher/add_units.dart';
import 'package:learningapp/teacher/editUnit.dart';
import 'package:learningapp/widgets/edit_unit_card.dart';

class Chatpersteachers extends ConsumerStatefulWidget {
  final String subjectId;
  final String subjectName;

  const Chatpersteachers({
    super.key,
    required this.subjectId,
    required this.subjectName,
  });

  @override
  ConsumerState<Chatpersteachers> createState() => _ChatpersteachersState();
}

class _ChatpersteachersState extends ConsumerState<Chatpersteachers> {
  int _selectedIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    Future.microtask(() {
      ref.read(unitsNotifierProvider.notifier).setsubject_id(widget.subjectId);
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
          widget.subjectName,
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
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                showDragHandle: true,
                builder: (context) => AddUnit(),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomSlidingSegmentedControl<int>(
              initialValue: _selectedIndex,
              children: const {0: Text("Units"), 1: Text("Exams")},
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12),
              ),
              thumbDecoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              onValueChanged: (value) {
                setState(() => _selectedIndex = value);
                _pageController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: [_buildUnitsGrid(), const StudentExams()],
      ),
    );
  }

  Widget _buildUnitsGrid() {
    final unitsAsync = ref.watch(unitsNotifierProvider);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: unitsAsync.when(
        data: (units) {
          if (units.isEmpty) {
            return const Center(child: Text('No units available'));
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
              itemCount: units.length,
              itemBuilder: (context, index) {
                final unit = units[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: 2,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50,
                    child: FadeInAnimation(
                      child: EditUnitCard(
                        title: unit.title,
                        image: unit.unit_image,
                        onDelete: () async {
                          //   final confirmed = await showDialog<bool>(
                          //     context: context,
                          //     builder: (context) => AlertDialog(
                          //       title: const Text('Delete Unit'),
                          //       content: Text('Are you sure you want to delete "${unit.title}"?'),
                          //       actions: [
                          //         TextButton(
                          //           onPressed: () => Navigator.pop(context, false),
                          //           child: const Text('Cancel'),
                          //         ),
                          //         TextButton(
                          //           onPressed: () => Navigator.pop(context, true),
                          //           style: TextButton.styleFrom(
                          //             foregroundColor: Colors.red,
                          //           ),
                          //           child: const Text('Delete'),
                          //         ),
                          //       ],
                          //     ),
                          //   );

                        //     if (confirmed == true && mounted) {
                        //       final success = await ref
                        //           .read(unitsNotifierProvider(widget.subjectId).notifier)
                        //           .deleteUnit(unitId: unit.id);

                        //       if (success && mounted) {
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //           const SnackBar(content: Text('Unit deleted successfully')),
                        //         );
                        //       }
                        //     }
                        },
                        onEdit: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            showDragHandle: true,
                            builder: (context) => EditUnit(unit: unit),
                          );
                        },
                        onTap: () {
                          // Navigate to lessons page
                          context.push('/adminunits/${unit.title}',extra: unit.unit_id);
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
                  ref.invalidate(unitsNotifierProvider);
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
