import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
    alignment: Alignment.center,
    child: CircularProgressIndicator(
      color: Provider.of<ThemeManager>(context, listen: false).themeData ==
              AppThemeData.lightTheme
          ? AppColors.primaryColor
          : AppColors.customBlackTint60,
    ),
  );
  }
}