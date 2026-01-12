import 'package:flutter/material.dart';
import 'package:learningapp/pages/home_page.dart';
import 'package:learningapp/pages/profilePage.dart';
import 'package:learningapp/pages/register.dart';
import 'package:learningapp/pages/new_content_upload_page.dart'; // Add this import

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _currentIndex = 0;

  // Added NewContentUploadPage to the pages list
  final _pages = [
    HomePage(),
    Profilepage(),
    const NewContentUploadPage(), // Your upload page
    Register(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.tertiary,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined, size: 24),
            label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline, size: 24),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.cloud_upload),
            icon: Icon(Icons.cloud_upload_outlined, size: 24),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.book),
            icon: Icon(Icons.book_outlined, size: 24),
            label: "Courses",
          ),
        ],
      ),
    );
  }
}
