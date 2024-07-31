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

class ComplexPolarFormResultScreen extends StatefulWidget {
  final Operation operation;
  const ComplexPolarFormResultScreen({super.key, required this.operation});

  @override
  State<ComplexPolarFormResultScreen> createState() =>
      _ComplexPolarFormResultScreenState();
}

class _ComplexPolarFormResultScreenState
    extends State<ComplexPolarFormResultScreen> {
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
      body: successComponent(
          context, widget.operation.results[0], widget.operation.results[1]),
    );
  }

  Widget successComponent(
      BuildContext context, String algebraicForm, String polarForm) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                "Polar Form",
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
                    complexResult(context, "converted complex number",
                        algebraicForm, polarForm),
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

  Column complexResult(BuildContext context, String title, String algebraicForm,
      String polarForm) {
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
                    context, "result", r"""$$""" + algebraicForm + r"""$$"""))),
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: TeXView(
                child: teXViewWidget(
                    context, "result", r"""$$""" + polarForm + r"""$$"""))),
      ],
    );
  }
}
