import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: const Color.fromRGBO(247, 247, 247, 1.0),
    primary: Colors.blue,
    secondary: Colors.black,
    tertiary: const Color.fromARGB(255, 234, 233, 233),
    onPrimary: Colors.black,
  ),
);
ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade800,
    primary: Color.fromARGB(255, 88, 62, 234),
    secondary: Colors.white,
    tertiary: const Color.fromARGB(255, 79, 79, 79),
    onPrimary: Colors.white,
  ),
);
