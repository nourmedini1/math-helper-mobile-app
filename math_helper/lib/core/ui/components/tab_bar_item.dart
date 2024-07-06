import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_helper/core/assets/fonts/fonts.dart';

class TabBarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const TabBarItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
          ),
          const SizedBox(
            width: 0,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: CustomFonts.robotoMedium,
            ),
          )
        ],
      ),
    );
  }
}
