import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class DerivativeResultScreen extends StatefulWidget {
  final Operation operation;
  const DerivativeResultScreen({super.key, required this.operation});

  @override
  State<DerivativeResultScreen> createState() => _DerivativeResultScreenState();
}

class _DerivativeResultScreenState extends State<DerivativeResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
          context: context,
          tabController: null,
          hasTabBar: false,
          appBarBottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Divider(
              height: 1,
              color: Provider.of<ThemeManager>(context).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.primaryColorTint50
                  : AppColors.customBlackTint60,
            ),
          ),
          hasHomeIcon: true),
      drawer: const CustomDrawer(),
      body: successWidget(context, "Derivative Result",
          widget.operation.results[0], widget.operation.results[1]),
    );
  }

  Widget successWidget(
      BuildContext context, String title, String expression, String result) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: AppColors.primaryColorTint50,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    fontFamily:
                        Theme.of(context).textTheme.titleMedium!.fontFamily),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Provider.of<ThemeManager>(context, listen: false)
                                .themeData ==
                            AppThemeData.lightTheme
                        ? AppColors.customBlackTint60
                        : AppColors.customBlackTint90, // Border color
                    width: 0.5, // Border width
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0), // Border radius
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    derivativeResult(
                        context, "The derivative result", expression, result),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Column derivativeResult(
      BuildContext context, String title, String expression, String result) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 20),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
                fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                color: Provider.of<ThemeManager>(context).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: TeXView(
                loadingWidgetBuilder: (context) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color:
                              Provider.of<ThemeManager>(context, listen: false)
                                          .themeData ==
                                      AppThemeData.lightTheme
                                  ? AppColors.primaryColor
                                  : AppColors.customBlackTint60,
                        ),
                      ),
                    ),
                child: teXViewWidget(
                    context, "result", r"""$$""" + expression + r"""$$"""))),
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: TeXView(
                child: teXViewWidget(
                    context, "result", r"""$$""" + result + r"""$$"""))),
      ],
    );
  }
}
