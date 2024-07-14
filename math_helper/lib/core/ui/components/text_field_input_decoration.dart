import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';

InputDecoration textFieldInputDecoration(BuildContext context, String hint) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    border: InputBorder.none,
    hintText: hint,
    hintStyle: TextStyle(
        fontFamily: Theme.of(context).textTheme.labelSmall!.fontFamily,
        color: AppColors.customBlackTint60,
        fontSize: 14),
  );
}
