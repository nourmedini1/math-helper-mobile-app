import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/product/presentation/widgets/numeric/numeric_product_screen.dart';
import 'package:math_helper/features/product/presentation/widgets/symbolic/symbolic_product_screen.dart';

import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with TickerProviderStateMixin {
  late TabController tabController;
  late TextEditingController symbolicExpressionController;
  late TextEditingController symbolicVariableController;
  late TextEditingController symbolicLowerLimitController;

  late TextEditingController numericExpressionController;
  late TextEditingController numericVariableController;
  late TextEditingController numericLowerLimitController;
  late TextEditingController numericUpperLimitController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    symbolicExpressionController = TextEditingController();
    symbolicVariableController = TextEditingController();
    symbolicLowerLimitController = TextEditingController();

    numericExpressionController = TextEditingController();
    numericVariableController = TextEditingController();
    numericLowerLimitController = TextEditingController();
    numericUpperLimitController = TextEditingController();
    
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    symbolicExpressionController.dispose();
    symbolicVariableController.dispose();
    symbolicLowerLimitController.dispose();
    numericExpressionController.dispose();
    numericVariableController.dispose();
    numericLowerLimitController.dispose();
    numericUpperLimitController.dispose();
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
        Center(child: SymbolicProductScreen(
          expressionController: symbolicExpressionController,
          variableController: symbolicVariableController,
          lowerBoundController: symbolicLowerLimitController,
        )),
        Center(child: NumericProductScreen(
          expressionController: numericExpressionController,
          variableController: numericVariableController,
          boundControllers: [
            numericLowerLimitController,
            numericUpperLimitController
          ],
        ))
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
                      title: ' Symbolic',
                      icon: Icon(Icons.bar_chart, size: 15),
                      fontSize: 14,
                    ),
                    TabBarItem(
                        fontSize: 14,
                        title: ' Numeric',
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
