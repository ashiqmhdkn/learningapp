import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/pages/student_exams.dart';
import 'package:learningapp/teacher/unitsuploadbottomsheet.dart';
import 'package:learningapp/widgets/lesson_card.dart';

final List<Lesson> lessons = List.generate(
  16,
  (index) => Lesson(
    title: 'Linear Algebra',
    part: 'Part ${index + 1}',
    thumbnail: 'lib/assets/physics.jpeg',
  ),
);

class Chatpersteachers extends StatefulWidget {
  final String name;
  const Chatpersteachers({super.key, required this.name});

  @override
  State<Chatpersteachers> createState() => _ChatpersteachersState();
}

class _ChatpersteachersState extends State<Chatpersteachers> {
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
          widget.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => UnitUploadbottomsheet(),
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
        children: [_unitsGrid(context), StudentExams()],
      ),
    );
  }

  Widget _unitsGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return LessonCard(
            lesson: lessons[index],
            onTap: () {
              context.push('/units/${lessons[index].title}');
            },
          );
        },
      ),
    );
  }
}
