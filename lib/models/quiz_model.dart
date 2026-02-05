import 'package:flutter/material.dart';

enum QuestionType { shortAnswer, longAnswer, multipleChoice }

class QuestionModel {
  QuestionType type;
  String title;
  String description;
  String answer;
  int marks;
  bool isRequired;

  // MCQ
  List<TextEditingController> optionControllers;
  int? correctOptionIndex;

  QuestionModel({
    required this.type,
    this.title = '',
    this.description = '',
    this.answer = '',
    this.marks = 1,
    this.isRequired = false,
    List<String>? options,
    this.correctOptionIndex,
  }) : optionControllers = (options ?? [''])
           .map((e) => TextEditingController(text: e))
           .toList();
}
