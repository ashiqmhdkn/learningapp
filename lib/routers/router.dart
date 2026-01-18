import 'package:go_router/go_router.dart';
import 'package:learningapp/pages/login_page.dart';
import 'package:learningapp/pages/profilePage.dart';
import 'package:learningapp/pages/register_page.dart';
import 'package:learningapp/pages/subject_page.dart';
import 'package:learningapp/pages/unit_page.dart';
import 'package:learningapp/pages/unitsPage.dart';
import 'package:learningapp/widgets/mainPage.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    /// HOME → SUBJECTS
    GoRoute(path: '/', builder: (context, state) => const Mainpage()),

    /// UNITS PAGE
    GoRoute(path: "/login", builder: (context, state) =>  Login_page()),
    GoRoute(path: "/register", builder: (context, state) =>  Register()),
    GoRoute(path: "/profile/:username", builder: (context, state) { 
      final username = state.pathParameters['username']!;
      return Profilepage(username: username);
    }),
    GoRoute(path: "/subjects/:courseName", builder: (context, state){ 
      final courseName = state.pathParameters['courseName']!;
      return SubjectPage(className: courseName);
    }),
    GoRoute(path: "/units/:unitName", builder: (context, state){ 
      final unitName = state.pathParameters['unitName']!;
      return Unitspage(unitName: unitName);
    }),


  ],
);
