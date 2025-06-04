// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';

class SubmitButton extends StatefulWidget {
  String? text;
  IconData? icon;
  Color? color;
  void Function()? onPressed;
  SubmitButton({super.key, this.text, this.icon, this.color, this.onPressed});

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: submitButtonDecoration(context),
    );
  }

  Container submitButtonDecoration(BuildContext context) {
    return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.color ?? AppColors.primaryColorTint50,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(
                      widget.icon ?? Icons.done_outline_outlined,
                      color: AppColors.customWhite,
                    ),
                  ),
                  Text(
                    widget.text ?? 'Get Results',
                    style: TextStyle(
                      color: AppColors.customWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          Theme.of(context).textTheme.labelMedium!.fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}