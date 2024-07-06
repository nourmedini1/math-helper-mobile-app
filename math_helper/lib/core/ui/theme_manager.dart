import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';

class ThemeManager with ChangeNotifier {
  ThemeData _themeData = AppThemeData.lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    themeData = _themeData == AppThemeData.lightTheme
        ? AppThemeData.darkTheme
        : AppThemeData.lightTheme;
  }
}
