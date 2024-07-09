import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class SearchItem extends StatelessWidget {
  final String title;
  final String description;
  final Widget leadingIcon;
  final Function onTap;
  const SearchItem(
      {super.key,
      required this.title,
      required this.description,
      required this.leadingIcon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                AppThemeData.lightTheme
            ? AppColors.customBlackTint90
            : AppColors.customDarkGrey,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          trailing: Icon(
            Icons.arrow_forward_ios_sharp,
            color: Provider.of<ThemeManager>(context).themeData ==
                    AppThemeData.lightTheme
                ? AppColors.primaryColor
                : AppColors.customBlackTint80,
          ),
          tileColor:
              Provider.of<ThemeManager>(context, listen: false).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.customBlackTint90
                  : AppColors.customDarkGrey,
          onTap: () => onTap,
          leading: leadingIcon,
          title: Text(title, style: Theme.of(context).textTheme.titleSmall),
          subtitle: Text(
            description,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ),
    );
  }
}
