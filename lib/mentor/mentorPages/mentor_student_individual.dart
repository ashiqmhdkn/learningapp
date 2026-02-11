import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:learningapp/mentor/mentorWidgets/exam_info_tile.dart';
import 'package:learningapp/widgets/customBoldText.dart';

class MentorStudentIndividual extends StatefulWidget {
  final String name;
  const MentorStudentIndividual({super.key, required this.name});

  @override
  State<MentorStudentIndividual> createState() =>
      _MentorStudentIndividualState();
}

class _MentorStudentIndividualState extends State<MentorStudentIndividual> {
  int _selectedIndex = 0;
  late final PageController _pageController;

  final List<String> subjects = const [
    "Maths",
    "Physics",
    "Biology",
    "Chemistry",
  ];

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
      appBar: AppBar(
        title: Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomSlidingSegmentedControl<int>(
              initialValue: _selectedIndex,
              children: {
                for (int i = 0; i < subjects.length; i++) i: Text(subjects[i]),
              },
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
        children: subjects.map((subject) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Customboldtext(
                  text: "$subject Overall Percentage :",
                  fontValue: 16,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: ExamInfoTile(
                        name: "$subject Exam ${index + 1}",
                        progress: index + 58,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
