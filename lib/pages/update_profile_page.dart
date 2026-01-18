import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/controller/authcontroller.dart';
import 'package:learningapp/models/user_model.dart';
import 'package:learningapp/widgets/customButtonOne.dart';
import 'package:learningapp/widgets/customPrimaryText.dart';
import 'package:learningapp/widgets/customTextBox.dart';

class UpdateProfilePage extends ConsumerWidget {
  final User user;
  const UpdateProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = authControllerProvider.watch(ref);
    TextEditingController _nameController = TextEditingController(text: user.username);
    TextEditingController _emailController = TextEditingController(text: user.email);
    TextEditingController _phoneController = TextEditingController(text: user.phone.toString());
    DropdownButtonFormField _roleDropdown = DropdownButtonFormField(
      items: ['student', 'teacher', 'admin']
          .map((role) => DropdownMenuItem(
                value: role,
                child: Text(role),
              ))
          .toList(),
      value: user.role,
      onChanged: (value) {
        _
      },
    );
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('lib/assets/image.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: colorScheme.primary,
                      child: const Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Customprimarytext(text: "Full Name", fontValue: 15),
            Customtextbox(
              hinttext: "Full Name",
              textController: _nameController,
              textFieldIcon: Icons.person,
            ),

            const SizedBox(height: 16),
            Customprimarytext(text: "Phone Number", fontValue: 15),
            Customtextbox(
              hinttext: "Phone Number",
              textController: _phoneController,
              textFieldIcon: Icons.phone,
            ),

            const SizedBox(height: 16),
            Customprimarytext(text: "Email Address", fontValue: 15),
            Customtextbox(
              hinttext: "Email Address",
              textController: _emailController,
              textFieldIcon: Icons.mail,
            ),

            const SizedBox(height: 16),
            Customprimarytext(text: "Role", fontValue: 15),

            DropdownButton<String>(
              items: ['student', 'teacher', 'admin']
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                  .toList(),
              value: user.role,
              onChanged: (value) {
                // Handle role change
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: Custombuttonone(text: "Save Changes", onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
