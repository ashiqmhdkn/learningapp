import 'package:flutter/material.dart';
import 'package:learningapp/mentor/mentorPages/mentors_exams.dart';
import 'package:learningapp/mentor/mentorPages/mentor_note.dart';
import 'package:learningapp/mentor/mentorPages/mentors_modules.dart';
import 'package:learningapp/teacher/quiz/quiz_creation.dart';
import 'package:learningapp/widgets/customButtonOne.dart';
import 'package:learningapp/widgets/customPrimaryText.dart';

class MentorLandingPage extends StatefulWidget {
  const MentorLandingPage({super.key});

  @override
  State<MentorLandingPage> createState() => _MentorLandingPageState();
}

class _MentorLandingPageState extends State<MentorLandingPage> {
  // Dummy batch data
  String? selectedBatch;
  final List<String> batches = [
    'Batch A - 2024',
    'Batch B - 2024',
    'Batch C - 2024',
    'Batch D - 2023',
    'Batch E - 2023',
    'Morning Batch',
    'Evening Batch',
    'Weekend Batch',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with theme colors
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.primary, // Uses theme primary color
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Top bar with search and profile
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.search,
                          color: colorScheme.secondary,
                          size: 24,
                        ),
                      ),
                      Text(
                        'Mentor',
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Batch Name Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colorScheme.tertiary),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedBatch,
                        hint: Text(
                          'Batch Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.secondary,
                          ),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: colorScheme.secondary,
                        ),
                        dropdownColor: colorScheme.surface,
                        items: batches.map((String batch) {
                          return DropdownMenuItem<String>(
                            value: batch,
                            child: Text(
                              batch,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.secondary,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBatch = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Course Structure Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course Structure',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(child: _buildCard(context, 'Exams')),
                        const SizedBox(width: 15),
                        Expanded(child: _buildCard(context, 'Notes')),
                        const SizedBox(width: 15),
                        Expanded(child: _buildCard(context, 'Modules')),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Others Section
                    Text(
                      'Others',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(child: _buildCard(context, 'Marks')),
                        const SizedBox(width: 15),
                        Expanded(child: _buildCard(context, 'Students')),
                        const SizedBox(width: 15),
                        Expanded(child: _buildCard(context, 'Notes')),
                        const SizedBox(width: 15),
                        Expanded(child: _buildCard(context, 'Modules')),
                        const SizedBox(width: 15),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Custombuttonone(
                text: "Create a Quiz",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return QuizCreation();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        if (title == 'Exams') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExamsPage()),
          );
        } else if (title == 'Notes') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotePage()),
          );
        } else if (title == 'Modules') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ModulePage()),
          );
        }
        // Add other navigation cases here
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: colorScheme.tertiary, width: 1.5),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
