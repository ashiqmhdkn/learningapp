import 'package:flutter/material.dart';
import 'package:learningapp/admin/admin_widgets/paymentCountContainer.dart';
import 'package:learningapp/widgets/customAppBar.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: Customappbar(title: "Dashboard"),
      body: Column(children: [Paymentcountcontainer()]),
    );
  }
}
