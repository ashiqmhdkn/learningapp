import 'package:flutter/material.dart';
import 'package:learningapp/pages/login_page.dart';
import 'package:learningapp/api/register.dart';
import 'package:learningapp/widgets/customButtonOne.dart';
import 'package:learningapp/widgets/customTextBox.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  // Role dropdown state
  String? _selectedRole;
  final List<String> _roles = ['Student', 'Teacher', 'Admin'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('lib/assets/image.png'),
              radius: 100,
            ),
            const SizedBox(height: 30),
            Customtextbox(
              hinttext: 'User name',
              textController: _namecontroller,
              textFieldIcon: Icons.person,
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              borderRadius: BorderRadius.circular(8),
              value: _selectedRole,
              hint: const Text("Select Role"),
              items: _roles.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.group),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Customtextbox(
              hinttext: 'Email',
              textController: _emailcontroller,
              textFieldIcon: Icons.email,
            ),
            const SizedBox(height: 15),
            Customtextbox(
              hinttext: 'Password',
              textController: _passwordcontroller,
              textFieldIcon: Icons.password_rounded,
            ),
            const SizedBox(height: 15),

            // Role drop

            const SizedBox(height: 15),
            Custombuttonone(
              text: 'SignUp',
              onTap: () async {
                try {
                  final jwt = await register(
                    _emailcontroller.text,
                    _passwordcontroller.text,
                    _namecontroller.text,
                    _selectedRole!, // Default to 'Student' if no role is selected
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Registration successful',
                      ),
                    ),
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registration failed: $e')),
                  );
                }
              },
              
            ),
          ],
        ),
      ),
    );
  }
}
