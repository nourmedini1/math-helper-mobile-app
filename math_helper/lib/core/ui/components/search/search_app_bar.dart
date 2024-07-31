import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/app_bar_border.dart';
import 'package:math_helper/core/ui/cubits/search/search_cubit.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/pages/home_page.dart';
import 'package:provider/provider.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final BuildContext theContext;
  const SearchAppBar(
      {super.key, required this.controller, required this.theContext});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(48);
}

class _SearchAppBarState extends State<SearchAppBar> {
  late FocusNode focusNode;
  bool isFocused = false;
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        hasText = widget.controller.text.isNotEmpty;
      });
    });

    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    //  widget.controller.removeListener(() {});
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      toolbarHeight: 48,
      leading: backButton(context),
      actions: themeToggler(context),
      bottom: bottomDelimiter(context),
      title: searchTextField(context),
    );
  }

  IconButton backButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                AppThemeData.lightTheme
            ? AppColors.primaryColor
            : AppColors.customBlackTint60,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  List<Widget> themeToggler(BuildContext context) {
    return <Widget>[
      IconButton(
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
      ),
      IconButton(
        icon: Icon(
          Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? Icons.sunny
              : Icons.nights_stay_rounded,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.primaryColor
              : AppColors.customBlackTint60,
        ),
        onPressed: () {
          Provider.of<ThemeManager>(context, listen: false).toggleTheme();
          BlocProvider.of<SearchCubit>(widget.theContext, listen: false)
              .search(widget.theContext, widget.controller.text);
        },
      ),
    ];
  }

  PreferredSize bottomDelimiter(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: AppBarBottomBorder(
          height: 1,
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.primaryColorTint50
              : AppColors.customBlackTint60,
        ),
      ),
    );
  }

  Padding searchTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                  AppThemeData.lightTheme
              ? AppColors.customBlackTint80.withOpacity(0.3)
              : AppColors.customBlackTint40.withOpacity(0.3),
          borderRadius: BorderRadius.circular(50),
        ),
        child: TextField(
          keyboardAppearance:
              Provider.of<ThemeManager>(context, listen: false).themeData ==
                      AppThemeData.lightTheme
                  ? Brightness.light
                  : Brightness.dark,
          onChanged: (value) =>
              BlocProvider.of<SearchCubit>(widget.theContext, listen: false)
                  .search(widget.theContext, value),
          focusNode: focusNode,
          maxLines: 1,
          cursorColor:
              Provider.of<ThemeManager>(context, listen: false).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.primaryColor
                  : AppColors.customWhite,
          cursorWidth: 0.8,
          style: TextStyle(
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlack
                      : AppColors.customWhite,
              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
              fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily),
          textAlign: TextAlign.start,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: Visibility(
              visible: widget.controller.text.isNotEmpty,
              child: IconButton(
                onPressed: () {
                  widget.controller.clear();
                  BlocProvider.of<SearchCubit>(widget.theContext, listen: false)
                      .search(widget.theContext, '');
                },
                icon: Icon(
                  Icons.close,
                  size: 20,
                  color: Provider.of<ThemeManager>(context, listen: false)
                              .themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.primaryColor
                      : AppColors.customWhite,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(bottom: 3, top: 4),
            hintText: "you're feeling curious?",
            hintStyle: TextStyle(
                color: Provider.of<ThemeManager>(context, listen: false)
                            .themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlackTint60
                    : AppColors.customBlackTint60,
                fontSize: 14),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search,
                size: 18,
                color: focusNode.hasFocus
                    ? Provider.of<ThemeManager>(context, listen: false)
                                .themeData ==
                            AppThemeData.lightTheme
                        ? AppColors.primaryColor
                        : AppColors.customWhite
                    : Provider.of<ThemeManager>(context, listen: false)
                                .themeData ==
                            AppThemeData.lightTheme
                        ? AppColors.customBlackTint60
                        : AppColors.customBlackTint60),
          ),
        ),
      ),
    );
  }
}
