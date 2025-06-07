import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/differential_equations/presentation/widgets/screens/first_order_ode/first_order_ode_screen.dart';
import 'package:math_helper/features/differential_equations/presentation/widgets/screens/second_order_ode/second_order_ode_screen.dart';
import 'package:math_helper/features/differential_equations/presentation/widgets/screens/third_order_ode/third_order_ode_screen.dart';
import 'package:provider/provider.dart';

class DifferentialEquationsPage extends StatefulWidget {
  const DifferentialEquationsPage({super.key});

  @override
  State<DifferentialEquationsPage> createState() =>
      _DifferentialEquationsPageState();
}

class _DifferentialEquationsPageState extends State<DifferentialEquationsPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  late TextEditingController firstOdeFirstCoefficient;
  late TextEditingController firstOdeSecondCoefficient;
  late TextEditingController firstOdeFirstInitialCondition;
  late TextEditingController firstOdeSecondInitialCondition;
  late TextEditingController firstOdeConstant;
  late TextEditingController firstOdeRightHandSide;

  late TextEditingController secondOdeFirstCoefficient;
  late TextEditingController secondOdeSecondCoefficient;
  late TextEditingController secondOdeFirstInitialCondition;
  late TextEditingController secondOdeSecondInitialCondition;
  late TextEditingController secondOdeThirdCoefficient;
  late TextEditingController secondOdeThirdInitialCondition;
  late TextEditingController secondOdeConstant;
  late TextEditingController secondOdeRightHandSide;

  late TextEditingController thirdOdeFirstCoefficient;
  late TextEditingController thirdOdeSecondCoefficient;
  late TextEditingController thirdOdeFirstInitialCondition;
  late TextEditingController thirdOdeSecondInitialCondition;
  late TextEditingController thirdOdeThirdCoefficient;
  late TextEditingController thirdOdeThirdInitialCondition;
  late TextEditingController thirdOdeFourthCoefficient;
  late TextEditingController thirdOdeFourthInitialCondition;
  late TextEditingController thirdOdeConstant;
  late TextEditingController thirdOdeRightHandSide;

  List<TextEditingController> firstOdeControllers = [];
  List<TextEditingController> secondOdeControllers = [];
  List<TextEditingController> thirdOdeControllers = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    firstOdeFirstCoefficient = TextEditingController();
    firstOdeSecondCoefficient = TextEditingController();
    firstOdeFirstInitialCondition = TextEditingController();
    firstOdeSecondInitialCondition = TextEditingController();
    firstOdeConstant = TextEditingController();
    firstOdeRightHandSide = TextEditingController();

    secondOdeFirstCoefficient = TextEditingController();
    secondOdeSecondCoefficient = TextEditingController();
    secondOdeFirstInitialCondition = TextEditingController();
    secondOdeSecondInitialCondition = TextEditingController();
    secondOdeThirdCoefficient = TextEditingController();
    secondOdeThirdInitialCondition = TextEditingController();
    secondOdeConstant = TextEditingController();
    secondOdeRightHandSide = TextEditingController();

    thirdOdeFirstCoefficient = TextEditingController();
    thirdOdeSecondCoefficient = TextEditingController();
    thirdOdeFirstInitialCondition = TextEditingController();
    thirdOdeSecondInitialCondition = TextEditingController();
    thirdOdeThirdCoefficient = TextEditingController();
    thirdOdeThirdInitialCondition = TextEditingController();
    thirdOdeFourthCoefficient = TextEditingController();
    thirdOdeFourthInitialCondition = TextEditingController();
    thirdOdeConstant = TextEditingController();
    thirdOdeRightHandSide = TextEditingController();

    firstOdeControllers = [
      firstOdeFirstCoefficient,
      firstOdeSecondCoefficient,
      firstOdeFirstInitialCondition,
      firstOdeSecondInitialCondition,
      firstOdeConstant,
      firstOdeRightHandSide
    ];

    secondOdeControllers = [
      secondOdeFirstCoefficient,
      secondOdeSecondCoefficient,
      secondOdeThirdCoefficient,
      secondOdeFirstInitialCondition,
      secondOdeSecondInitialCondition,
      secondOdeThirdInitialCondition,
      secondOdeConstant,
      secondOdeRightHandSide
    ];

    thirdOdeControllers = [
      thirdOdeFirstCoefficient,
      thirdOdeSecondCoefficient,
      thirdOdeThirdCoefficient,
      thirdOdeFourthCoefficient,
      thirdOdeFirstInitialCondition,
      thirdOdeSecondInitialCondition,
      thirdOdeThirdInitialCondition,
      thirdOdeFourthInitialCondition,
      thirdOdeConstant,
      thirdOdeRightHandSide
    ];
  }

  @override
  void dispose() {
    tabController.dispose();
    firstOdeFirstCoefficient.dispose();
    firstOdeSecondCoefficient.dispose();
    firstOdeFirstInitialCondition.dispose();
    firstOdeSecondInitialCondition.dispose();
    firstOdeConstant.dispose();
    firstOdeRightHandSide.dispose();

    secondOdeFirstCoefficient.dispose();
    secondOdeSecondCoefficient.dispose();
    secondOdeFirstInitialCondition.dispose();
    secondOdeSecondInitialCondition.dispose();
    secondOdeThirdCoefficient.dispose();
    secondOdeThirdInitialCondition.dispose();
    secondOdeConstant.dispose();
    secondOdeRightHandSide.dispose();

    thirdOdeFirstCoefficient.dispose();
    thirdOdeSecondCoefficient.dispose();
    thirdOdeFirstInitialCondition.dispose();
    thirdOdeSecondInitialCondition.dispose();
    thirdOdeThirdCoefficient.dispose();
    thirdOdeThirdInitialCondition.dispose();
    thirdOdeFourthCoefficient.dispose();
    thirdOdeFourthInitialCondition.dispose();
    thirdOdeConstant.dispose();
    thirdOdeRightHandSide.dispose();

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
      body: TabBarView(
        controller: tabController,
        children: [
          Center(child: FirstOrderOdeScreen(
            coefficientControllers: firstOdeControllers.sublist(0, 2),
            initialConditionControllers:
                firstOdeControllers.sublist(2, 4),
            constantController: firstOdeControllers[4],
            RHSController: firstOdeControllers[5],
          )),
          Center(child: SecondOrderOdeScreen(
            coefficientControllers: secondOdeControllers.sublist(0, 3),
            initialConditionControllers:
                secondOdeControllers.sublist(3, 6),
            constantController: secondOdeControllers[6],
            RHSController: secondOdeControllers[7],
          )),
          Center(
            child: ThirdOrderOdeScreen(
              coefficientControllers: thirdOdeControllers.sublist(0, 4),
              initialConditionControllers:
                  thirdOdeControllers.sublist(4, 8),
              constantController: thirdOdeControllers[8],
              RHSController: thirdOdeControllers[9],
            ),
          ),
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
                      title: ' First',
                      icon: Icon(Icons.bar_chart, size: 15),
                      fontSize: 14,
                    ),
                    TabBarItem(
                        fontSize: 14,
                        title: ' Second',
                        icon: Icon(Icons.bar_chart, size: 15)),
                    TabBarItem(
                        fontSize: 14,
                        title: ' Third',
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
