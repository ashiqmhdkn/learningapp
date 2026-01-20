import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/api/profileapi.dart';
import 'package:learningapp/controller/authcontroller.dart';
 // your AuthController

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final authController = ref.read(authControllerProvider.notifier);

    // Initialize (load token from SharedPreferences)
    await authController.initialize();

    final token = ref.read(authControllerProvider);

    if (token == null || token == "loading") {
      // No token → go to login
      GoRouter.of(context).go('/login');
      return;
    }

    // If you need profile API call:
    final user = await profileapi(token);
    if(user == Error()){
      GoRouter.of(context).go('/login');
    }
    else{ // your existing API
    switch (user.role) {
      case 'admin':
        GoRouter.of(context).go('/adminnav');
        break;
      case 'teacher':
        GoRouter.of(context).go("/teachernav");
        break;
      default:
        GoRouter.of(context).go('/');
    }}
  }

  @override
  Widget build(BuildContext context) {// set theme according to system
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child:CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage('lib/assets/image.png'),
        ), // simple splash loader
      ),
    );
  }
}
