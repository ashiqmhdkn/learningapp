import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:learningapp/admin/admin_pages/admin_dashboard.dart';
import 'package:learningapp/mentor/mentorPages/mentor_students.dart';
import 'package:learningapp/mentor/mentorPages/students_marks.dart';
import 'package:learningapp/pages/coursePage.dart';
import 'package:learningapp/pages/home_page.dart';
import 'package:learningapp/teacher/new_content_upload_page.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _previousIndex = 0;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  final _pages = const [
    HomePage(),
    CourseSubjectPage(),
    AdminDashboard(),
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
            GButton(icon: Icons.book_outlined, text: 'Courses'),
            GButton(icon: Icons.person_outline, text: 'Admin'),
            GButton(icon: Icons.grade_outlined, text: 'Marks'),
          ],
        ),
      ),
    );
  }
}
