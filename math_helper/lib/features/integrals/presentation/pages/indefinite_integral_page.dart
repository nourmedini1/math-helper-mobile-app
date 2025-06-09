import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/theme_manager.dart';

import 'package:math_helper/features/integrals/presentation/widgets/indefinite_integral/double/double_indefinite_integral_screen.dart';
import 'package:math_helper/features/integrals/presentation/widgets/indefinite_integral/single/single_indefinite_integral_screen.dart';
import 'package:math_helper/features/integrals/presentation/widgets/indefinite_integral/triple/triple_indefinite_integral_screen.dart';
import 'package:provider/provider.dart';

class IndefinitePrimitivePage extends StatefulWidget {
  const IndefinitePrimitivePage({super.key});

  @override
  State<IndefinitePrimitivePage> createState() =>
      _IndefinitePrimitivePageState();
}

class _IndefinitePrimitivePageState extends State<IndefinitePrimitivePage>
    with TickerProviderStateMixin {
  late TabController tabController;

  late TextEditingController singleExpressionController;
  late TextEditingController singleVariableController;

  late TextEditingController doubleExpressionController;
  late TextEditingController doubleVariableController;

  late TextEditingController tripleExpressionController;
  late TextEditingController tripleVariableController;




  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    singleExpressionController = TextEditingController();
    singleVariableController = TextEditingController();

    doubleExpressionController = TextEditingController();
    doubleVariableController = TextEditingController();

    tripleExpressionController = TextEditingController();
    tripleVariableController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    singleExpressionController.dispose();
    singleVariableController.dispose();

    doubleExpressionController.dispose();
    doubleVariableController.dispose();

    tripleExpressionController.dispose();
    tripleVariableController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          context: context,
          tabController: tabController,
          hasTabBar: true,
          appBarBottom: appBarBottom(context),
          hasHomeIcon: true),
      drawer: const CustomDrawer(),
      body: TabBarView(controller: tabController, children: [
        Center(
          child: SingleIndefiniteIntegralScreen(
            expressionController: singleExpressionController,
            variableController: singleVariableController, )
        ),
        Center(
          child: DoubleIndefiniteIntegralScreen(
            expressionController: doubleExpressionController,
            variableController: doubleVariableController,
          ),
        ),
        Center(
          child: TripleIndefiniteIntegralScreen(
            expressionController: tripleExpressionController,
            variableController: tripleVariableController,
          ),
        ),
      ]),
    );
  }

 
  PreferredSize appBarBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Column(
        children: [
          Divider(
            height: 1,
            color:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
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
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator:  BoxDecoration(
                    color: Provider.of<ThemeManager>(context, listen: false)
                                .themeData ==
                            AppThemeData.lightTheme
                        ? AppColors.primaryColorTint50
                        : AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: AppColors.customWhite,
                  unselectedLabelColor:
                      Provider.of<ThemeManager>(context, listen: false)
                                  .themeData ==
                              AppThemeData.lightTheme
                          ? AppColors.customBlack
                          : AppColors.customBlackTint90,
                  tabs: const [
                    TabBarItem(
                      title: ' Single',
                      icon: Icon(Icons.area_chart, size: 15),
                      fontSize: 14,
                    ),
                    TabBarItem(
                        fontSize: 14,
                        title: ' Double',
                        icon: Icon(Icons.bar_chart, size: 15)),
                    TabBarItem(
                        fontSize: 14,
                        title: ' Triple',
                        icon: Icon(Icons.bar_chart, size: 15)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  

}
