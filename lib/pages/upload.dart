import 'package:flutter/material.dart';
import 'package:learningapp/widgets/customButtonOne.dart';
import 'package:learningapp/widgets/customTextBox.dart';

class Upload extends StatelessWidget {
  const Upload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("New content Upload")));
  }
}
