import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:learningapp/mentor/mentorPages/mentor_landing.dart';
import 'package:learningapp/mentor/mentorPages/students_marks.dart';
import 'package:learningapp/pages/home_page.dart';

class Teachernav extends StatefulWidget {
  const Teachernav({super.key});

  @override
  State<Teachernav> createState() => _TeachernavState();
}

class _TeachernavState extends State<Teachernav>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _previousIndex = 0;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  // OLD CODE - COMMENTED OUT:
  // final _pages = const [
  //   HomePage(),
  //   CourseSubjectPage(),
  //   AdminDashboard(),
  //   StudentsMarks(),
  // ];

  // NEW CODE:
  final _pages = const [
    HomePage(),
    MentorLandingPage(),
    StudentsMarks(),
    
    
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = const AlwaysStoppedAnimation(Offset.zero);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTabChange(int newIndex) {
    if (newIndex == _currentIndex) return;

    _previousIndex = _currentIndex;
    _currentIndex = newIndex;

    final isForward = _currentIndex > _previousIndex;

    _slideAnimation = Tween<Offset>(
      begin: isForward ? const Offset(1, 0) : const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward(from: 0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _pages[_previousIndex],
          SlideTransition(
            position: _slideAnimation,
            child: _pages[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: colorScheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: GNav(
          selectedIndex: _currentIndex,
          onTabChange: _onTabChange,
          gap: 8,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          tabBorderRadius: 16,
          activeColor: colorScheme.onPrimary,
          tabBackgroundColor: colorScheme.primary,
          color: colorScheme.secondary,
          tabs: const [
            GButton(icon: Icons.home_outlined, text: 'Home'),
            // GButton(icon: Icons.person_outline, text: 'Admin'), 
            //// OLD CODE
            GButton(icon: Icons.school_outlined, text: 'Mentor'),
            GButton(icon:   Icons.grade_outlined, text: 'Marks'),
          ],
        ),
      ),
    );
  }
}
