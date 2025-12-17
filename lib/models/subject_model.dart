import 'package:flutter/material.dart';
import 'unit_model.dart';

class Subject {
  final String title;
  final String subtitle;
  final String image;
  final Color color;
  final List<Unit> units;

  Subject({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.color,
    required this.units,
  });
}
