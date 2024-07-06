import 'package:flutter/material.dart';
import 'package:math_helper/core/assets/fonts/fonts.dart';
import 'package:math_helper/core/ui/app_colors.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.primaryColorTint50,
        width: 300,
      ),
      brightness: Brightness.light,
      cardColor: AppColors.customBlackTint90,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.customBlackTint90,
          toolbarHeight: 100,
          centerTitle: false,
          titleTextStyle: TextStyle(
              fontFamily: CustomFonts.ubuntuBold,
              fontSize: 24,
              fontStyle: FontStyle.normal,
              color: AppColors.primaryColor)),
      colorScheme: const ColorScheme.light(
        background: AppColors.customBlackTint90,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontFamily: CustomFonts.ubuntuBold,
            fontSize: 48,
            color: AppColors.customBlack),
        displayMedium: TextStyle(
            fontFamily: CustomFonts.ubuntuBold,
            fontSize: 36,
            color: AppColors.customBlack),
        displaySmall: TextStyle(
            fontFamily: CustomFonts.ubuntuBold,
            fontSize: 24,
            color: AppColors.customBlack),
        titleLarge: TextStyle(
            fontFamily: CustomFonts.ubuntuBold,
            fontSize: 36,
            color: AppColors.customBlack),
        titleMedium: TextStyle(
            fontFamily: CustomFonts.ubuntuBold,
            fontSize: 24,
            color: AppColors.customBlack),
        titleSmall: TextStyle(
            fontFamily: CustomFonts.ubuntuBold,
            fontSize: 16,
            color: AppColors.customBlack),
        bodyLarge: TextStyle(
            fontFamily: CustomFonts.robotoBold,
            fontSize: 24,
            color: AppColors.customBlack),
        bodyMedium: TextStyle(
            fontFamily: CustomFonts.robotoMedium,
            fontSize: 14,
            color: AppColors.customBlack),
        bodySmall: TextStyle(
            fontFamily: CustomFonts.robotoRegular,
            fontSize: 14,
            color: AppColors.customBlack),
        labelLarge: TextStyle(
            fontFamily: CustomFonts.robotoLight,
            fontSize: 24,
            color: AppColors.customBlackTint40),
        labelMedium: TextStyle(
            fontFamily: CustomFonts.robotoLight,
            fontSize: 16,
            color: AppColors.customBlackTint40),
        labelSmall: TextStyle(
            fontFamily: CustomFonts.robotoLight,
            fontSize: 12,
            color: AppColors.customBlackTint40),
      ));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.customDarkGrey,
        width: 300,
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.customDarkGrey,
          // elevation: 0,
          toolbarHeight: 100,
          centerTitle: false,
          titleTextStyle: TextStyle(
              fontFamily: CustomFonts.ubuntuBold,
              fontSize: 24,
              fontStyle: FontStyle.normal,
              color: AppColors.customWhite)),
      colorScheme: const ColorScheme.dark(background: AppColors.customDarkGrey),
      cardColor: AppColors.customDarkGrey,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontFamily: CustomFonts.ubuntuBold,
            fontSize: 48,
            color: AppColors.customWhite),
        displayMedium: TextStyle(
            fontFamily: CustomFonts.ubuntuBold,
            fontSize: 36,
            color: AppColors.customWhite),
        displaySmall: TextStyle(
            fontFamily: CustomFonts.ubuntuBold,
            fontSize: 24,
            color: AppColors.customWhite),
        titleLarge: TextStyle(
            fontFamily: CustomFonts.ubuntuBold,
            fontSize: 36,
            color: AppColors.customWhite),
        titleMedium: TextStyle(
            fontFamily: CustomFonts.ubuntuBold,
            fontSize: 24,
            color: AppColors.customWhite),
        titleSmall: TextStyle(
            fontFamily: CustomFonts.ubuntuBold,
            fontSize: 16,
            color: AppColors.customWhite),
        bodyLarge: TextStyle(
            fontFamily: CustomFonts.robotoBold,
            fontSize: 24,
            color: AppColors.customWhite),
        bodyMedium: TextStyle(
            fontFamily: CustomFonts.robotoMedium,
            fontSize: 14,
            color: AppColors.customWhite),
        bodySmall: TextStyle(
            fontFamily: CustomFonts.robotoRegular,
            fontSize: 14,
            color: AppColors.customWhite),
        labelLarge: TextStyle(
            fontFamily: CustomFonts.robotoLight,
            fontSize: 24,
            color: AppColors.customBlackTint80),
        labelMedium: TextStyle(
            fontFamily: CustomFonts.robotoLight,
            fontSize: 16,
            color: AppColors.customBlackTint80),
        labelSmall: TextStyle(
            fontFamily: CustomFonts.robotoLight,
            fontSize: 12,
            color: AppColors.customBlackTint80),
      ));
}
