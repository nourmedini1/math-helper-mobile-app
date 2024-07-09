import 'package:flutter/cupertino.dart';

class AppBarBottomBorder extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;
  final Color color;

  const AppBarBottomBorder({super.key, this.height = 1.0, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: color, width: height),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
