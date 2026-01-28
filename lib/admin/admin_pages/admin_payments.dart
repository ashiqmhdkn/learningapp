import 'package:flutter/material.dart';
import 'package:learningapp/admin/admin_widgets/payment_tile.dart';
import 'package:learningapp/models/payment_model.dart';
import 'package:learningapp/widgets/customAppBar.dart';

class AdminPayments extends StatelessWidget {
  const AdminPayments({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Payment> payments = List.generate(
      15,
      (index) => Payment(
        id: "pay_${index + 1}",
        studentId: "stu_${index + 1}",
        studentName: "Student ${index + 1}",
        courseName: index.isEven ? "Maths" : "Class X",
        amount: 999 + (index * 100),
        status: PaymentStatus.values[index % PaymentStatus.values.length],

        // time metadata
        createdAt: DateTime.now().subtract(
          Duration(hours: index * 3),
        ),
        updatedAt: DateTime.now(),
        paidAt: index.isEven ? DateTime.now() : null,
      ),
    );

    return Scaffold(
      appBar: Customappbar(title: "Payments"),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: payments.length,
        itemBuilder: (context, index) {
          final payment = payments[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: PaymentInfoTile(
              studentName: payment.studentName,
              courseName: payment.courseName,
              amount: payment.amount,
              status: payment.status.name,
              time: payment.createdAt, 
              onTap: () {
                // future
              },
            ),
          );
        },
      ),
    );
  }
}
