import 'package:go_router/go_router.dart';
import 'package:learningapp/pages/unit_page.dart';
import 'package:learningapp/widgets/mainPage.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    /// HOME → SUBJECTS
    GoRoute(path: '/', builder: (context, state) => const Mainpage()),

    /// UNITS PAGE
    GoRoute(
      path: '/units/:className/:subjectTitle',
      builder: (context, state) {
        final className = state.pathParameters['className']!;
        final subjectTitle = state.pathParameters['subjectTitle']!;

        return UnitPage(className: className, subjectTitle: subjectTitle);
      },
    ),
  ],
);
