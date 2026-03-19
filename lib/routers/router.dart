import 'package:go_router/go_router.dart';
import 'package:learningapp/admin/admin_navbar.dart';
import 'package:learningapp/admin/admin_pages/admin_vide0_notes_exam.dart';
import 'package:learningapp/login/new_login_page.dart';
import 'package:learningapp/login/new_register_page.dart';
import 'package:learningapp/mentor/mentorPages/mentor_student_individual.dart';
import 'package:learningapp/mentor/mentorPages/mentor_video_access.dart';
import 'package:learningapp/mentor/mentorPages/new_batch_creation.dart';
import 'package:learningapp/mentor/mentorWidgets/mentor_nav_bar.dart';
import 'package:learningapp/models/user_model.dart';
import 'package:learningapp/pages/chatpers_units.dart';
import 'package:learningapp/pages/profilePage.dart';
import 'package:learningapp/pages/splash.dart';
import 'package:learningapp/pages/unitsPage.dart';
import 'package:learningapp/pages/update_profile_page.dart';
import 'package:learningapp/teacher/upate_units.dart';
import 'package:learningapp/teacher/add_units.dart';
import 'package:learningapp/test.dart';
import 'package:learningapp/widgets/student_navbar.dart';

final router = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),

    /// HOME → SUBJECTS
    GoRoute(path: '/', builder: (context, state) => const StudentNavbar()),

    GoRoute(
      path: '/mentornavbar',
      builder: (context, state) => const MentorNavBar(),
    ),

    /// UNITS PAGE
    GoRoute(path: "/login", builder: (context, state) => const NewLoginPage()),
    GoRoute(
      path: "/register",
      builder: (context, state) => const NewRegisterPage(),
    ),
    GoRoute(path: "/adminnav", builder: (context, state) => const Adminnav()),
    GoRoute(path: "/test", builder: (context, state) => const Test()),

    // GoRoute(path: "/upload",builder: (context, state) => NewContentUploadPage(),),
    // GoRoute(
    //   path: "/teachernav",
    //   builder: (context, state) => const Teachernav(),
    // ),
    // GoRoute(
    //   path: "/upload",
    //   builder: (context, state) => NewContentUploadPage(),
    // ),
    GoRoute(
      path: "/profile/:username",
      builder: (context, state) {
        final username = state.pathParameters['username']!;
        return Profilepage(username: username);
      },
    ),
    GoRoute(
      path: "/units/:unitname",
      builder: (context, state) {
        final unitname = state.pathParameters['unitname']!;
        final unitId = state.extra as String;
        return Unitspage(unitName: unitname, unitId: unitId);
      },
    ),
    GoRoute(
      path: "/adminunits/:unitname",
      builder: (context, state) {
        final unitname = state.pathParameters['unitname']!;
        final unitId = state.extra as String;
        return AdminVide0NotesExam(unitName: unitname, unitId: unitId);
      },
    ),

    GoRoute(
      path: "/editProfile",
      builder: (context, state) {
        final user = state.extra as User;
        return UpdateProfilePage(user: user);
      },
    ),

    GoRoute(
      path: "/addunits",
      builder: (context, state) {
        return AddUnit();
      },
    ),
    GoRoute(
      path: "/chapters/:name",
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        final subjectId = state.extra as String;
        return ChatpersUnits(name: name, subjectId: subjectId);
      },
    ),
    GoRoute(
      path: "/chapterupdate/:name",
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        final subjectId = state.extra as String;
        // final subject_id=state.pathParameters['subject_id']!;
        return Chatpersteachers(subjectId: subjectId, subjectName: name);
      },
    ),
    //Mentor routes
    GoRoute(
      path: "/mentorStudentIndividual/:name",
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        return MentorStudentIndividual(name: name);
      },
    ),
    GoRoute(
      path: "/mentorvideoaccess/:name",
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        return MentorVideoAccess(name: name);
      },
    ),
    GoRoute(
      path: "/newbatchcreation",
      builder: (context, state) => NewBatchCreation(),
    ),
  ],
);
