import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';

Container resetButton(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColorTint50),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? MainAxisAlignment.center
                : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.customWhite,
            ),
          ),
          Text(
            "Go back",
            style: TextStyle(
              color: AppColors.customWhite,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: Theme.of(context).textTheme.labelMedium!.fontFamily,
            ),
          ),
        ],
      ),
    ),
  );
}
