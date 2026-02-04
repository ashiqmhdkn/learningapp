import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningapp/models/subject_model.dart';

class SubjectTile extends StatelessWidget {
  final Subject subject;

  const SubjectTile({required this.subject, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        child: Center(
          child: Column(children: [
            Image.network(
              subject.subject_image,
              width: 40,
              height: 40,
            ),
            Text(subject.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          
          ],),
        ),
        onTap: () {
        context.push('/units/Class 9/${subject.title}');
      },
      ) 
    );
  }
}