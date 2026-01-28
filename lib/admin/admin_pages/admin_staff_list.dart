import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/admin/admin_widgets/staff_info_tile.dart';
import 'package:learningapp/models/staff_model.dart';

class AdminStaffList extends StatelessWidget {
  final String role;
  const AdminStaffList({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final roles = ["Teacher", "Mentor", "Coordinator", "Collaborator"];

    final List<Staff> staffList = List.generate(
      20,
      (index) => Staff(
        id: "staff_${index + 1}",
        name: "Staff ${index + 1}",
        role: roles[index % roles.length],
      ),
    );

    final filteredStaff = staffList
        .where((staff) => staff.role == role)
        .toList();

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: filteredStaff.length,
      itemBuilder: (context, index) {
        final staff = filteredStaff[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: StaffInfoTile(
            name: staff.name,
            role: staff.role,
            onTap: () {
              context.push("/profile/${staff.name}", extra: staff);
            },
          ),
        );
      },
    );
  }
}
