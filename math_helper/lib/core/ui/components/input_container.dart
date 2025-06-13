// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class InputContainer extends StatelessWidget {
  String? title;
  Widget body;
  Widget? submitButton;
  Widget? clearButton;
  InputContainer({super.key, this.title, required this.body, this.submitButton, this.clearButton,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        inputContainerTitle(context),
        inputContainerBody(context),
        inputContainerSubmitButton(),
        inputContainerClearButton()
      ]
    );
  }

  Padding inputContainerClearButton() {
    return Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 64, vertical: 5),
          child: clearButton ?? const SizedBox.shrink(),
        );
  }

  Padding inputContainerSubmitButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 0),
        child: submitButton ?? const SizedBox.shrink(),
        );
  }

  Padding inputContainerBody(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child:Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Provider.of<ThemeManager>(context, listen: false)
                          .themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.customBlackTint60
                  : AppColors.customBlackTint90, 
              width: 0.5, 
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0), 
            ),
          ),
          child: body,
        ),
      );
  }

  Widget inputContainerTitle(BuildContext context) {
    return Align(
          alignment: Alignment.center,
          child: Text(
            title ?? '',
            style: TextStyle(
                color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
          ? AppColors.primaryColorTint50
          : AppColors.primaryColor,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                fontFamily:
                    Theme.of(context).textTheme.titleMedium!.fontFamily),
          ),
        );
  }
}