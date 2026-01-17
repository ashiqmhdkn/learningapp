import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: const Color.fromRGBO(247, 247, 247, 1.0),
    primary: Color.fromARGB(255, 38, 0, 255),
    secondary: Colors.orangeAccent,
    tertiary: Colors.black,
  ),
);
ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade800,
    primary: Color.fromARGB(255, 38, 0, 255),
    secondary: Colors.orangeAccent,
    tertiary: Colors.white,
  ),
);
