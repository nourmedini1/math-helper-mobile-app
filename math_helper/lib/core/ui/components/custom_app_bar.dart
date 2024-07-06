import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_helper/core/strings.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/tab_bar_item.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final BuildContext context;
  final TabController tabController;
  const CustomAppBar(
      {super.key, required this.context, required this.tabController});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(Theme.of(context).appBarTheme.toolbarHeight!);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Column(
          children: [
            Divider(
              height: 1,
              color: Provider.of<ThemeManager>(context).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.primaryColorTint50
                  : AppColors.customBlackTint60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Provider.of<ThemeManager>(context).themeData ==
                            AppThemeData.lightTheme
                        ? AppColors.customBlackTint90
                        : AppColors.customDarkGrey,
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: const BoxDecoration(
                      color: AppColors.primaryColorTint50,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelColor: AppColors.customWhite,
                    unselectedLabelColor:
                        Provider.of<ThemeManager>(context).themeData ==
                                AppThemeData.lightTheme
                            ? AppColors.customBlack
                            : AppColors.customBlackTint90,
                    tabs: const [
                      TabBarItem(title: 'Home', icon: Icons.home),
                      TabBarItem(title: 'Statistics', icon: Icons.bar_chart),
                      TabBarItem(
                          title: 'History', icon: Icons.watch_later_outlined),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
              Navigator.pushNamed(context, '/search');
            },
            icon: Icon(
              Icons.search_rounded,
              color: Provider.of<ThemeManager>(context).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.primaryColor
                  : AppColors.customBlackTint60,
            )),
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