import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/api/profileapi.dart';
import 'package:learningapp/controller/authcontroller.dart';
import 'package:learningapp/models/user_model.dart';
import 'package:learningapp/widgets/calender.dart';
import 'package:learningapp/widgets/courseCompletionPieChart.dart';
import 'package:learningapp/widgets/customPrimaryText.dart';
import 'package:learningapp/widgets/darkOrLight.dart';
import 'package:learningapp/widgets/hAndLScoreContainer.dart';
import 'package:learningapp/widgets/streak.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilepage extends ConsumerWidget {
  final String username;
  const Profilepage({super.key, required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(actions: [Darkorlight()], scrolledUnderElevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('lib/assets/image.png'),
                ),
                const SizedBox(width: 60),
                Column(
                  children: [
                    Customprimarytext(text: username, fontValue: 25),
                    Customprimarytext(text: "Class XII", fontValue: 15),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 30,
                      width: 90,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        onPressed: () async{
                          context.push('/login');
                          var tokon=SharedPreferences.getInstance().then((prefs) {
                            return prefs.getString('auth_token') ?? '';
                          });
                          User user = await profileapi(await tokon);
                          GoRouter.of(context)
                              .go('/editProfile', extra: user);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 12,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Handlscorecontainer(
                  text: "Highest Score",
                  mark: 99,
                  subject: "Computer",
                ),
                const SizedBox(width: 40),
                Handlscorecontainer(
                  text: "Lowest Score",
                  mark: 20,
                  subject: "Chemistry",
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Streak Widget
            SizedBox(height: 150, width: double.infinity, child: Streak()),

            const SizedBox(height: 10),

            // Calendar Widget
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CalendarWidget(
                initialDate: DateTime.now(),
                onDateSelected: (date) {
                  print('Selected date: $date');
                },
              ),
            ),

            const SizedBox(height: 10),

            // Course Completion Chart
            Coursecompletionpiechart(),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
