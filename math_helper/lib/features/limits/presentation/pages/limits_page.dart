import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/limits/presentation/widgets/double/double_limit_screen.dart';
import 'package:math_helper/features/limits/presentation/widgets/single/single_limit_screen.dart';
import 'package:math_helper/features/limits/presentation/widgets/triple/triple_limit_screen.dart';
import 'package:provider/provider.dart';

class LimitsPage extends StatefulWidget {
  const LimitsPage({super.key});

  @override
  State<LimitsPage> createState() => _LimitsPageState();
}

class _LimitsPageState extends State<LimitsPage> with TickerProviderStateMixin {
  late TabController tabController;

  late TextEditingController singleExpressionController;
  late TextEditingController singleVariableController;
  late TextEditingController singleXBoundController;
  late TextEditingController singleXSignController;

  late TextEditingController doubleExpressionController;
  late TextEditingController doubleVariableController;
  late TextEditingController doubleXBoundController;
  late TextEditingController doubleXSignController;
  late TextEditingController doubleYBoundController;
  late TextEditingController doubleYSignController;

  late TextEditingController tripleExpressionController;
  late TextEditingController tripleVariableController;
  late TextEditingController tripleXBoundController;
  late TextEditingController tripleXSignController;
  late TextEditingController tripleYBoundController;
  late TextEditingController tripleYSignController;
  late TextEditingController tripleZBoundController;
  late TextEditingController tripleZSignController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    singleExpressionController = TextEditingController();
    singleVariableController = TextEditingController();
    singleXBoundController = TextEditingController();
    singleXSignController = TextEditingController();

    doubleExpressionController = TextEditingController();
    doubleVariableController = TextEditingController();
    doubleXBoundController = TextEditingController();
    doubleXSignController = TextEditingController();
    doubleYBoundController = TextEditingController();
    doubleYSignController = TextEditingController();

    tripleExpressionController = TextEditingController();
    tripleVariableController = TextEditingController();
    tripleXBoundController = TextEditingController();
    tripleXSignController = TextEditingController();
    tripleYBoundController = TextEditingController();
    tripleYSignController = TextEditingController();
    tripleZBoundController = TextEditingController();
    tripleZSignController = TextEditingController();

  

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    singleExpressionController.dispose();
    singleVariableController.dispose();
    singleXBoundController.dispose();
    singleXSignController.dispose();
    doubleExpressionController.dispose();
    doubleVariableController.dispose();
    doubleXBoundController.dispose();
    doubleXSignController.dispose();
    doubleYBoundController.dispose();
    doubleYSignController.dispose();
    tripleExpressionController.dispose();
    tripleVariableController.dispose();
    tripleXBoundController.dispose();
    tripleXSignController.dispose();
    tripleYBoundController.dispose();
    tripleYSignController.dispose();
    tripleZBoundController.dispose();
    tripleZSignController.dispose();

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
          child: SingleLimitScreen(
            expressionController: singleExpressionController,
            variableController: singleVariableController,
            boundControllers: [singleXBoundController],
            signControllers: [singleXSignController],
          ),
        ),
        Center(
          child: DoubleLimitScreen(
            expressionController: doubleExpressionController,
            variableController: doubleVariableController,
            boundControllers: [
              doubleXBoundController,
              doubleYBoundController
            ],
            signControllers: [
              doubleXSignController,
              doubleYSignController
            ],
          ),
        ),
        Center(
          child: TripleLimitScreen(
            expressionController: tripleExpressionController,
            variableController: tripleVariableController,
            boundControllers: [
              tripleXBoundController,
              tripleYBoundController,
              tripleZBoundController
            ],
            signControllers: [
              tripleXSignController,
              tripleYSignController,
              tripleZSignController
            ],
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
                    borderRadius:const BorderRadius.all(Radius.circular(10)),
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
                      icon: Icon(Icons.bar_chart, size: 15),
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
