import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';

Container clearButtonDecoration(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.secondaryColor),
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
              Icons.clear,
              color: AppColors.customWhite,
            ),
          ),
          Text(
            "Clear",
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
