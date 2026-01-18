import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';


class UnitsController extends StateNotifier<int> {
  final PageController pageController = PageController();

  UnitsController() : super(0);

  void setIndex(int index) {
    state = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void pageChanged(int index) {
    state = index;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

final unitsControllerProvider =
    StateNotifierProvider<UnitsController, int>((ref) {
  return UnitsController();
});
