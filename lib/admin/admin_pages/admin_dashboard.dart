import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/admin/admin_widgets/manageTeachers.dart';
import 'package:learningapp/admin/admin_widgets/paymentCountContainer.dart';
import 'package:learningapp/controller/authcontroller.dart';
import 'package:learningapp/widgets/customAppBar.dart';
import 'package:learningapp/widgets/customBoldText.dart';
class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.read(authControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: Customappbar(title: "Dashboard"),
      body: FutureBuilder<String?>(
        future: authState.getToken(), // async fetch
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No token found. Please login."));
          }

          final token = snapshot.data!;
          return SingleChildScrollView(
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
                  child: ManageTeachers(token: token), // ✅ safe usage
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
