import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/strings.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';

import 'package:math_helper/core/ui/cubits/search/search_cubit.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/pages/home_page.dart';
import 'package:math_helper/pages/search_page.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final BuildContext context;
  final TabController? tabController;
  final bool hasTabBar;
  final bool hasHomeIcon;
  final PreferredSizeWidget appBarBottom;
  const CustomAppBar(
      {super.key,
      required this.context,
      required this.tabController,
      required this.hasTabBar,
      required this.appBarBottom,
      required this.hasHomeIcon});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(hasTabBar ? 100 : 48);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      toolbarHeight: widget.hasTabBar ? 100 : 48,
      bottom: widget.appBarBottom,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: Text(
        Strings.appName,
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Provider.of<ThemeManager>(context).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.primaryColor
              : AppColors.customBlackTint60,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ic<SearchCubit>(),
                  child: const SearchPage(),
                ),
              ));
            },
            icon: Icon(
              Icons.search_rounded,
              color: Provider.of<ThemeManager>(context).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.primaryColor
                  : AppColors.customBlackTint60,
            )),
        widget.hasHomeIcon
            ? IconButton(
                icon: Icon(
                  Icons.home_rounded,
                  color: Provider.of<ThemeManager>(context).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.primaryColor
                      : AppColors.customBlackTint60,
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false);
                },
              )
            : const SizedBox(
                width: 0,
              ),
        IconButton(
          icon: Icon(
            Provider.of<ThemeManager>(context).themeData ==
                    AppThemeData.lightTheme
                ? Icons.sunny
                : Icons.nights_stay_rounded,
            color: Provider.of<ThemeManager>(context).themeData ==
                    AppThemeData.lightTheme
                ? AppColors.primaryColor
                : AppColors.customBlackTint60,
          ),
          onPressed: () {
            Provider.of<ThemeManager>(context, listen: false).toggleTheme();
          },
        ),
      ],
    );
  }
}
