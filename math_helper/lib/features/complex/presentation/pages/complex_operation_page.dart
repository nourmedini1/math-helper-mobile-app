import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';

import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/complex_operations/complex_addition_screen.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/complex_operations/complex_multiplication_screen.dart';
import 'package:math_helper/features/complex/presentation/widgets/screens/complex_operations/complex_substraction_screen.dart';
import 'package:provider/provider.dart';


class ComplexOperationPage extends StatefulWidget {
  const ComplexOperationPage({super.key});

  @override
  State<ComplexOperationPage> createState() => _ComplexOperationPageState();
}

class _ComplexOperationPageState extends State<ComplexOperationPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  late TextEditingController additionFirstRealController;
  late TextEditingController additionSecondRealController;
  late TextEditingController additionFirstImaginaryController;
  late TextEditingController additionSecondImaginaryController;

  late TextEditingController multiplicationFirstRealController;
  late TextEditingController multiplicationSecondRealController;
  late TextEditingController multiplicationFirstImaginaryController;
  late TextEditingController multiplicationSecondImaginaryController;

  late TextEditingController substractionFirstRealController;
  late TextEditingController substractionSecondRealController;
  late TextEditingController substractionFirstImaginaryController;
  late TextEditingController substractionSecondImaginaryController;
  
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    additionFirstRealController = TextEditingController();
    additionSecondRealController = TextEditingController();
    additionFirstImaginaryController = TextEditingController();
    additionSecondImaginaryController = TextEditingController();

    multiplicationFirstRealController = TextEditingController();
    multiplicationSecondRealController = TextEditingController();
    multiplicationFirstImaginaryController = TextEditingController();
    multiplicationSecondImaginaryController = TextEditingController();

    substractionFirstRealController = TextEditingController();
    substractionSecondRealController = TextEditingController();
    substractionFirstImaginaryController = TextEditingController();
    substractionSecondImaginaryController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    additionFirstRealController.dispose();
    additionSecondRealController.dispose();
    additionFirstImaginaryController.dispose();
    additionSecondImaginaryController.dispose();

    multiplicationFirstRealController.dispose();
    multiplicationSecondRealController.dispose();
    multiplicationFirstImaginaryController.dispose();
    multiplicationSecondImaginaryController.dispose();

    substractionFirstRealController.dispose();
    substractionSecondRealController.dispose();
    substractionFirstImaginaryController.dispose();
    substractionSecondImaginaryController.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
          context: context,
          tabController: tabController,
          hasHomeIcon: true,
          hasTabBar: true,
          appBarBottom: appBarBottom(context)),
      drawer: const CustomDrawer(),
      body: TabBarView(
        controller: tabController,
        children: [
          Center(
              child: ComplexAdditionScreen(controllers: [
                additionFirstRealController,
                additionSecondRealController,
                additionFirstImaginaryController,
                additionSecondImaginaryController
              ])),
          Center(
              child: ComplexSubstractionScreen(controllers :  [
            substractionFirstRealController,
            substractionSecondRealController,
            substractionFirstImaginaryController,
            substractionSecondImaginaryController
          ])),
          Center(
              child: ComplexMultiplicationScreen(controllers  : [
            multiplicationFirstRealController,
            multiplicationSecondRealController,
            multiplicationFirstImaginaryController,
            multiplicationSecondImaginaryController
          ])),
        ],
      ),
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
                  color: Provider.of<ThemeManager>(context, listen: false)
                              .themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlackTint90
                      : AppColors.customDarkGrey,
                ),
                child: TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: const BoxDecoration(
                    color: AppColors.primaryColorTint50,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      title: 'Add',
                      icon: Icon(Icons.bar_chart, size: 15),
                      fontSize: 14,
                    ),
                    TabBarItem(
                        fontSize: 14,
                        title: 'Substract',
                        icon: Icon(Icons.bar_chart, size: 15)),
                    TabBarItem(
                        fontSize: 14,
                        title: 'Multiply',
                        icon: Icon(
                          Icons.bar_chart,
                          size: 15,
                        )),
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
