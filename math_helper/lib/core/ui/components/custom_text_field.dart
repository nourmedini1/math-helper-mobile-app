// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String? label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  void Function(String) onChanged;

  CustomTextField({super.key,
    required this.hint,
    this.label,
    required this.controller,
    this.keyboardType,
    required this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.label != null
            ? Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 5),
                child: TextFieldLabel(label: widget.label!),
              )
            : const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            height: 50,
            decoration: textFieldDecoration(context),
            child: textField(context),)
        
          ),
      ],
    );
  }

  TextField textField(BuildContext context) {
    return TextField(
            onChanged: widget.onChanged,
            controller: widget.controller,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            textInputAction: TextInputAction.next,
              maxLines: 1,
              cursorColor:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.primaryColor
                      : AppColors.customWhite,
              cursorWidth: 0.8,
              style: TextStyle(
                  color: Provider.of<ThemeManager>(context, listen: false)
                              .themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                  fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily),
              textAlign: TextAlign.start,
              decoration: textFieldInputDecoration(context, widget.hint)
          );
  }

  BoxDecoration textFieldDecoration(BuildContext context) {
  return BoxDecoration(
    color: Provider.of<ThemeManager>(context, listen: false).themeData ==
            AppThemeData.lightTheme
        ? AppColors.customBlackTint80.withOpacity(0.3)
        : AppColors.customBlackTint40.withOpacity(0.3),
    borderRadius: BorderRadius.circular(10),
  );
}

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

}