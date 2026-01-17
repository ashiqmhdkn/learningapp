import 'package:flutter/material.dart';
import 'package:learningapp/api/login.dart';
import 'package:learningapp/pages/register_page.dart';
import 'package:learningapp/widgets/customButtonOne.dart';
import 'package:learningapp/widgets/customTextBox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login_page extends ConsumerWidget {
  Login_page({super.key});

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView( // <-- FIX
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('lib/assets/image.png'),
                radius: 100,
              ),
              const SizedBox(height: 30),
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

              // LOGIN BUTTON
              Custombuttonone(
                text: authState == null ? 'Sign In' : 'Signing...',
                onTap: () {
                  ref.read(authControllerProvider.notifier).login(
                            _emailcontroller.text,
                            _passwordcontroller.text,
                          ).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Logged in Successfully!")),
                            );
                              Navigator.of(context).pushReplacementNamed('/');  
                          });
                },
              ),

              const SizedBox(height: 10),

              Custombuttonone(
                text: 'Go to Register',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => Register()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
