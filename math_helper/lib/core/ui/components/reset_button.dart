import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';

// ignore: must_be_immutable
class ResetButton extends StatefulWidget {
  String? text;
  IconData? icon;
  Color? color;
  void Function()? onPressed;
  ResetButton({super.key, this.text, this.icon, this.color, this.onPressed});

  @override
  State<ResetButton> createState() => _ResetButtonState();
}

class _ResetButtonState extends State<ResetButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 10),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: resetButtonDecoration(context),
      ),
    );
  }
  Container resetButtonDecoration(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.color ?? AppColors.primaryColorTint50),
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
            widget.text ?? 'Go Back',
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

}





