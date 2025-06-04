import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';



class TextFieldLabel extends StatelessWidget {
  final String label;
  const TextFieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
    label,
    style: TextStyle(
      fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
      fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
      color: Provider.of<ThemeManager>(context, listen: false).themeData ==
              AppThemeData.lightTheme
          ? AppColors.customBlack
          : AppColors.customBlackTint80,
    ),
  );
  }
}

