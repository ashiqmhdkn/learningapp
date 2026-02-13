import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:learningapp/admin/admin_widgets/admin_subject_exams.dart';
import 'package:learningapp/admin/admin_widgets/admin_subject_notes.dart';
import 'package:learningapp/admin/admin_widgets/admin_subject_videos.dart';
import 'package:learningapp/teacher/addVideo.dart';

class AdminVide0NotesExam extends StatefulWidget {
  final String unitName;
  final String unitId;
  const AdminVide0NotesExam({super.key, required this.unitName,required this.unitId});

  @override
  State<AdminVide0NotesExam> createState() => _AdminVide0NotesExamState();
}

class _AdminVide0NotesExamState extends State<AdminVide0NotesExam> {
  int _selectedIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
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
        title: Text(
          widget.unitName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomSlidingSegmentedControl<int>(
              initialValue: _selectedIndex,
              children: const {
                0: Text("Classes"),
                1: Text("Exam"),
                2: Text("Notes"),
              },
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              thumbDecoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              onValueChanged: (value) {
                setState(() {
                  _selectedIndex = value;
                });

                _pageController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                showDragHandle: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return AddVideo(unitid: widget.unitId,); // NO padding here
                },
              );
            },

            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.primary,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          AdminSubjectVideos(unitName: widget.unitName,unit_id:widget.unitId),
          AdminSubjectExams(),
          AdminSubjectNotes(unitName: widget.unitName),
        ],
      ),
    );
  }
}
