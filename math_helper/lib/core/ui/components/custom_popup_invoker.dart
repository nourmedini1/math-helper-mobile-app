import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class CustomPopupInvoker extends StatefulWidget {
  final void Function() onTap;
  final String text;
  const CustomPopupInvoker({super.key, required this.onTap, required this.text});

  @override
  State<CustomPopupInvoker> createState() => _CustomPopupInvokerState();
}

class _CustomPopupInvokerState extends State<CustomPopupInvoker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child:Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration (
    color: Provider.of<ThemeManager>(context, listen: false).themeData ==
            AppThemeData.lightTheme
        ? AppColors.customBlackTint80.withOpacity(0.3)
        : AppColors.customBlackTint40.withOpacity(0.3),
    borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 15, left: 20),
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            widget.text,
            style: TextStyle(
                fontFamily: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .fontFamily,
                color:
                    AppColors.customBlackTint60,
                fontSize: 14),
          ),
        ),
      ), 
    );
  }
}