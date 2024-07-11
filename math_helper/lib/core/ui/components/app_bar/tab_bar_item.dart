import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_helper/core/assets/fonts/fonts.dart';

class TabBarItem extends StatelessWidget {
  final String title;
  final double? fontSize;
  final Widget icon;
  const TabBarItem(
      {super.key, required this.icon, required this.title, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            width: 0,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: CustomFonts.robotoMedium,
            ),
          )
        ],
      ),
    );
  }
}
