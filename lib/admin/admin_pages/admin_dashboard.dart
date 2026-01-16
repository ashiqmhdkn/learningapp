import 'package:flutter/material.dart';
import 'package:learningapp/admin/admin_widgets/manageTeachers.dart';
import 'package:learningapp/admin/admin_widgets/paymentCountContainer.dart';
import 'package:learningapp/widgets/customAppBar.dart';
import 'package:learningapp/widgets/customBoldText.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: ManageTeachers(),
            ),
          ],
        ),
      ),
    );
  }
}
