import 'package:flutter/material.dart';
import 'package:learningapp/admin/admin_widgets/manageTeachers.dart';
import 'package:learningapp/admin/admin_widgets/paymentCountContainer.dart';
import 'package:learningapp/widgets/customAppBar.dart';
import 'package:learningapp/widgets/customBoldText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: Customappbar(title: "Dashboard"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Paymentcountcontainer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Customboldtext(
                text: "Manage Your Teachers",
                fontValue: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<SharedPreferences>(
                future: prefsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final prefs = snapshot.data;
                  final token = prefs?.getString('token');
                  return ManageTeachers(token: token ?? 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNzJmNjFlYmQtYTM2ZS00YTRmLTgwMjctZGFhZjMxYjg1NWYxIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzcwMjEzODk5fQ.u_z-xly9s-Glkj0WiHANps9uc05eyEu2pWMgPik63mI');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
