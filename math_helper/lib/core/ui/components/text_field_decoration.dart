import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

BoxDecoration textFieldDecoration(BuildContext context) {
  return BoxDecoration(
    color: Provider.of<ThemeManager>(context, listen: false).themeData ==
            AppThemeData.lightTheme
        ? AppColors.customBlackTint80.withOpacity(0.3)
        : AppColors.customBlackTint40.withOpacity(0.3),
    borderRadius: BorderRadius.circular(10),
  );
}
