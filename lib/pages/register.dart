import 'package:flutter/material.dart';
import 'package:learningapp/widgets/customButtonOne.dart';
import 'package:learningapp/widgets/customTextBox.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('lib/assets/image.png'),
              radius: 100,
            ),
            SizedBox(height: 30),
            Customtextbox(
              hinttext: 'User name',
              textController: _namecontroller,
              textFieldIcon: Icons.person,
            ),
            SizedBox(height: 15),
            Customtextbox(
              hinttext: 'Email',
              textController: _emailcontroller,
              textFieldIcon: Icons.email,
            ),
            SizedBox(height: 15),
            Customtextbox(
              hinttext: 'Password',
              textController: _passwordcontroller,
              textFieldIcon: Icons.password_rounded,
            ),
            SizedBox(height: 15),
            Custombuttonone(text: 'SignUp', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
