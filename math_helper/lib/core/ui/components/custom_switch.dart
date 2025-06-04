import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';

class CustomSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isLight;
  const CustomSwitch({super.key, required this.value,required this.label, required this.onChanged, required this.isLight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFieldLabel(label: label),
          const SizedBox(width: 10),
          Switch(
            activeColor: AppColors.primaryColor,
            inactiveThumbColor: isLight
                ? AppColors.customBlackTint60
                : AppColors.customBlackTint90,
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  
}