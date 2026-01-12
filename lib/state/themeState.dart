import 'package:flutter/material.dart';

import 'package:flutter_riverpod/legacy.dart';
import 'package:learningapp/Theme/theme.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(lightmode);

  void enableDarkMode() {
    state = darkmode;
  }

  void enableLightMode() {
    state = lightmode;
  }

  void toggleTheme() {
    state = state.brightness == Brightness.dark ? lightmode : darkmode;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>(
  (ref) => ThemeNotifier(),
);
