import 'package:flutter/material.dart';
import 'package:quel_prof/data/my_colors.dart' as my_colors;

class ProviderNavigation extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  goBack() {
    _currentPage = 0;
    notifyListeners();
    return false;
  }
}
