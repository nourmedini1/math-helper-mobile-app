import 'package:flutter/material.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';

class ThemeManager with ChangeNotifier {
  final LocalStorageService localStorageService = ic<LocalStorageService>();
  ThemeData _themeData = AppThemeData.lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  init() async {
    final bool isDarkMode = localStorageService.getIsDarkMode();
    themeData = isDarkMode ? AppThemeData.darkTheme : AppThemeData.lightTheme;
    notifyListeners();
  }

  void toggleTheme() async {
    themeData = _themeData == AppThemeData.lightTheme
        ? AppThemeData.darkTheme
        : AppThemeData.lightTheme;
    await localStorageService
        .setIsDarkMode(themeData == AppThemeData.darkTheme);
  }
}
