import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

TeXViewWidget teXViewWidget(BuildContext context, String title, String body) {
  return TeXViewDocument(body,
      style: TeXViewStyle(
          fontStyle: TeXViewFontStyle(
            fontSize: 16,
          ),
          contentColor:
              Provider.of<ThemeManager>(context, listen: false).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.customBlack
                  : AppColors.customWhite,
          borderRadius: const TeXViewBorderRadius.all(10),
          border: TeXViewBorder.all(TeXViewBorderDecoration(
            borderWidth: 2,
            borderStyle: TeXViewBorderStyle.solid,
            borderColor:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.secondaryColor
                    : AppColors.customBlackTint20,
          )),
          backgroundColor:
              Provider.of<ThemeManager>(context, listen: false).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.customWhite.withOpacity(0.3)
                  : AppColors.customBlackTint40.withOpacity(0.3),
          margin: const TeXViewMargin.only(top: 10, right: 10)));
}
