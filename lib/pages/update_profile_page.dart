import 'package:flutter/material.dart';
import 'package:learningapp/widgets/customButtonOne.dart';
import 'package:learningapp/widgets/customPrimaryText.dart';
import 'package:learningapp/widgets/customTextBox.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _DateofbirthController = TextEditingController();
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
            Customprimarytext(text: "Date Of Birth", fontValue: 15),

            Customtextbox(
              hinttext: "DD / MM / YYYY",
              textController: _DateofbirthController,
              textFieldIcon: Icons.calendar_month,
            ),
            const SizedBox(height: 14),
            Customprimarytext(text: "Role", fontValue: 15),
            DropdownButtonFormField<String>(
              initialValue: "Student",
              items: const [
                DropdownMenuItem(value: "Admin", child: Text("Admin")),
                DropdownMenuItem(value: "Student", child: Text("Student")),
                DropdownMenuItem(value: "Mentor", child: Text("Mentor")),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
            ),
            const SizedBox(height: 15),

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
