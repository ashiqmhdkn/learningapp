import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/admin/admin_widgets/batch_courseview.dart';
import 'package:learningapp/admin/admin_widgets/paymentCountContainer.dart';
import 'package:learningapp/controller/authcontroller.dart';
import 'package:learningapp/widgets/customAppBar.dart';
import 'package:learningapp/widgets/customBoldText.dart';
class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: Customappbar(title: "Dashboard"),
      body: 
           Column(
            children: [
              Paymentcountcontainer(),
              const Center(
                child: const Customboldtext(
                  text: "Manage Your Batches",
                  fontValue: 20,
                ),
              ),
              Expanded(child: BatchCourseview()),
              //   child: ManageTeachers(token: token), // ✅ safe usage
            ],
          ),
      );
  }
}
