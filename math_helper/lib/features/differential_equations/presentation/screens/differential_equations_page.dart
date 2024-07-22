import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/clear_button_decoration.dart';
import 'package:math_helper/core/ui/components/custom_rect_tween.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/components/hero_dialog_route.dart';
import 'package:math_helper/core/ui/components/input_title.dart';
import 'package:math_helper/core/ui/components/loading_component.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/components/text_field_input_decoration.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_request.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/first_order_differential_equation/first_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/second_order_differential_equation/second_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/third_order_differential_equation/third_order_differential_equation_bloc.dart';
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

  bool isFirstOdeFieldsReady = false;
  bool isSecondOdeFieldsReady = false;
  bool isThirdOdeFieldsReady = false;

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
          Center(child: firstOdeScreen(context)),
          Center(child: secondOdeScreen(context)),
          Center(
            child: thirdOdeScreen(context),
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

  Widget firstOdeScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<FirstOrderDifferentialEquationBloc,
          FirstOrderDifferentialEquationState>(
        listener: (context, state) {
          if (state is FirstOrderDifferentialEquationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(
                    color: AppColors.customWhite,
                  ),
                ),
                backgroundColor: AppColors.customRed,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FirstOrderDifferentialEquationInitial) {
            return initialFirstOdeWidget(context);
          } else if (state is FirstOrderDifferentialEquationLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is FirstOrderDifferentialEquationSuccess) {
            return successWidget(context, "First Order Ode",
                state.response.equation, state.response.solution, 'first');
          } else if (state is FirstOrderDifferentialEquationFailure) {
            return initialFirstOdeWidget(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget secondOdeScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<SecondOrderDifferentialEquationBloc,
          SecondOrderDifferentialEquationState>(
        listener: (context, state) {
          if (state is SecondOrderDifferentialEquationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(
                    color: AppColors.customWhite,
                  ),
                ),
                backgroundColor: AppColors.customRed,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SecondOrderDifferentialEquationInitial) {
            return initialSecondOdeWidget(context);
          } else if (state is SecondOrderDifferentialEquationLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is SecondOrderDifferentialEquationSuccess) {
            return successWidget(context, "Second Order Ode",
                state.response.equation, state.response.solution, 'second');
          } else if (state is SecondOrderDifferentialEquationFailure) {
            return initialSecondOdeWidget(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget thirdOdeScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<ThirdOrderDifferentialEquationBloc,
          ThirdOrderDifferentialEquationState>(
        listener: (context, state) {
          if (state is ThirdOrderDifferentialEquationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(
                    color: AppColors.customWhite,
                  ),
                ),
                backgroundColor: AppColors.customRed,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ThirdOrderDifferentialEquationInitial) {
            return initialThirdOdeWidget(context);
          } else if (state is ThirdOrderDifferentialEquationLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is ThirdOrderDifferentialEquationSuccess) {
            return successWidget(context, "Third Order Ode",
                state.response.equation, state.response.solution, 'third');
          } else if (state is ThirdOrderDifferentialEquationFailure) {
            return initialThirdOdeWidget(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget initialThirdOdeWidget(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Third Order Ode",
            style: TextStyle(
                color: AppColors.primaryColorTint50,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                fontFamily:
                    Theme.of(context).textTheme.titleMedium!.fontFamily),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The coefficients"),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                      .push(HeroDialogRoute(builder: (context) {
                                    return CustomPopupWidget(
                                        fourthController:
                                            thirdOdeFourthCoefficient,
                                        fourthHint:
                                            "Input the fourth coefficient",
                                        fourthLabel: "Fourth coefficent",
                                        thirdController:
                                            thirdOdeThirdCoefficient,
                                        thirdLabel: "Third coefficient",
                                        thirdHint:
                                            "Input the third coefficient",
                                        title: "Third Order Ode",
                                        tag: "third-coefficients-popup",
                                        operation: "third",
                                        context: context,
                                        firstLabel: "First coefficient",
                                        firstHint:
                                            "Input the first coefficient",
                                        firstController:
                                            thirdOdeFirstCoefficient,
                                        secondLabel: "Second coefficient",
                                        secondHint:
                                            "Input the second coefficient",
                                        secondController:
                                            thirdOdeSecondCoefficient);
                                  })),
                              child: Hero(
                                  tag: "third-coefficients-popup",
                                  child: Material(
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: textFieldDecoration(context),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 20),
                                        child: Text(
                                          "Input the Ode's coefficients",
                                          style: TextStyle(
                                              fontFamily: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .fontFamily,
                                              color:
                                                  AppColors.customBlackTint60,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  )))),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The initial conditions"),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                      .push(HeroDialogRoute(builder: (context) {
                                    return CustomPopupWidget(
                                        fourthHint: "Example: x,f'''(x)",
                                        thirdController:
                                            thirdOdeThirdInitialCondition,
                                        thirdLabel: "Third initial condition",
                                        thirdHint: "Example: x,f''(x)",
                                        title: "Third Order Ode",
                                        tag: "third-initial-conditions-popup",
                                        operation: "third",
                                        context: context,
                                        firstLabel: "First initial condition",
                                        firstHint: "Example: x,f(x)",
                                        firstController:
                                            thirdOdeFirstInitialCondition,
                                        secondLabel: "Second initial condition",
                                        secondHint: "Example: x,f'(x)",
                                        fourthController:
                                            thirdOdeFourthInitialCondition,
                                        fourthLabel: "Fourth initial condition",
                                        secondController:
                                            thirdOdeSecondInitialCondition);
                                  })),
                              child: Hero(
                                  tag: "third-initial-conditions-popup",
                                  child: Material(
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: textFieldDecoration(context),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 20),
                                        child: Text(
                                          "Input the Ode's initial conditions",
                                          style: TextStyle(
                                              fontFamily: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .fontFamily,
                                              color:
                                                  AppColors.customBlackTint60,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  )))),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The constant"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: textField(context, thirdOdeConstant,
                            "Default is 0", "third", double.infinity),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The right hand side"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: textField(context, thirdOdeRightHandSide,
                            "Default is 0", "third", double.infinity),
                      ),
                    ])),
          ),
        ),
        submitButton(context, "third", isThirdOdeFieldsReady),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: clearButton(context, thirdOdeControllers, "third"),
        )
      ],
    );
  }

  Widget initialSecondOdeWidget(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.center,
        child: Text(
          "Second Order Ode",
          style: TextStyle(
              color: AppColors.primaryColorTint50,
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  Provider.of<ThemeManager>(context, listen: false).themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlackTint60
                      : AppColors.customBlackTint90, // Border color
              width: 0.5, // Border width
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0), // Border radius
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: inputTitle(context, "The coefficients"),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                    .push(HeroDialogRoute(builder: (context) {
                                  return CustomPopupWidget(
                                      thirdController:
                                          secondOdeThirdCoefficient,
                                      thirdLabel: "Third coefficient",
                                      thirdHint: "Input the third coefficient",
                                      title: "Second Order Ode",
                                      tag: "second-coefficients-popup",
                                      operation: "second",
                                      context: context,
                                      firstLabel: "First coefficient",
                                      firstHint: "Input the first coefficient",
                                      firstController:
                                          secondOdeFirstCoefficient,
                                      secondLabel: "Second coefficient",
                                      secondHint:
                                          "Input the second coefficient",
                                      secondController:
                                          secondOdeSecondCoefficient);
                                })),
                            child: Hero(
                                tag: "second-coefficients-popup",
                                child: Material(
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: textFieldDecoration(context),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 20),
                                      child: Text(
                                        "Input the Ode's coefficients",
                                        style: TextStyle(
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .fontFamily,
                                            color: AppColors.customBlackTint60,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                )))),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: inputTitle(context, "The initial conditions"),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                    .push(HeroDialogRoute(builder: (context) {
                                  return CustomPopupWidget(
                                      thirdController:
                                          secondOdeThirdInitialCondition,
                                      thirdLabel: "Third initial condition",
                                      thirdHint: "Example: x,f''(x)",
                                      title: "Second Order Ode",
                                      tag: "second-initial-conditions-popup",
                                      operation: "second",
                                      context: context,
                                      firstLabel: "First initial condition",
                                      firstHint: "Example: x,f(x)",
                                      firstController:
                                          secondOdeFirstInitialCondition,
                                      secondLabel: "Second initial condition",
                                      secondHint: "Example: x,f'(x)",
                                      secondController:
                                          secondOdeSecondInitialCondition);
                                })),
                            child: Hero(
                                tag: "second-initial-conditions-popup",
                                child: Material(
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: textFieldDecoration(context),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 20),
                                      child: Text(
                                        "Input the Ode's initial conditions",
                                        style: TextStyle(
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .fontFamily,
                                            color: AppColors.customBlackTint60,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                )))),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: inputTitle(context, "The constant"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(context, secondOdeConstant,
                          "Default is 0", "second", double.infinity),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: inputTitle(context, "The right hand side"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(context, secondOdeRightHandSide,
                          "Default is 0", "second", double.infinity),
                    ),
                  ])),
        ),
      ),
      submitButton(context, "second", isSecondOdeFieldsReady),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: clearButton(context, secondOdeControllers, "second"),
      ),
    ]);
  }

  Widget successWidget(BuildContext context, String title, String expression,
      String result, String operation) {
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
                    odeResult(context, "The Ode result", expression, result),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: odeResetButtons(context, operation),
          ),
        ],
      ),
    );
  }

  Widget odeResetButtons(BuildContext context, String operation) {
    return GestureDetector(
      onTap: () {
        if (operation == "first") {
          BlocProvider.of<FirstOrderDifferentialEquationBloc>(context)
              .add(const FirstOrderDifferentialEquationReset());
        } else if (operation == "second") {
          BlocProvider.of<SecondOrderDifferentialEquationBloc>(context)
              .add(const SecondOrderDifferentialEquationReset());
        } else {
          BlocProvider.of<ThirdOrderDifferentialEquationBloc>(context)
              .add(const ThirdOrderDifferentialEquationReset());
        }
      },
      child: resetButton(context),
    );
  }

  Column odeResult(
      BuildContext context, String title, String expression, String result) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
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
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TeXView(
                style: const TeXViewStyle(textAlign: TeXViewTextAlign.left),
                loadingWidgetBuilder: (context) => Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: Provider.of<ThemeManager>(context, listen: false)
                                    .themeData ==
                                AppThemeData.lightTheme
                            ? AppColors.primaryColor
                            : AppColors.customBlackTint60,
                      ),
                    ),
                child: teXViewWidget(
                    context, "result", r"""$$""" + expression + r"""$$"""))),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TeXView(
                child: teXViewWidget(
                    context, "result", r"""$$""" + result + r"""$$"""))),
      ],
    );
  }

  Widget initialFirstOdeWidget(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "First Order Ode",
            style: TextStyle(
                color: AppColors.primaryColorTint50,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                fontFamily:
                    Theme.of(context).textTheme.titleMedium!.fontFamily),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The coefficients"),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                      .push(HeroDialogRoute(builder: (context) {
                                    return CustomPopupWidget(
                                        title: "First Order Ode",
                                        tag: "first-coefficients-popup",
                                        operation: "first",
                                        context: context,
                                        firstLabel: "First coefficient",
                                        firstHint:
                                            "Input the first coefficient",
                                        firstController:
                                            firstOdeFirstCoefficient,
                                        secondLabel: "Second coefficient",
                                        secondHint:
                                            "Input the second coefficient",
                                        secondController:
                                            firstOdeSecondCoefficient);
                                  })),
                              child: Hero(
                                  tag: "first-coefficients-popup",
                                  child: Material(
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: textFieldDecoration(context),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 20),
                                        child: Text(
                                          "Input the Ode's coefficients",
                                          style: TextStyle(
                                              fontFamily: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .fontFamily,
                                              color:
                                                  AppColors.customBlackTint60,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  )))),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The initial conditions"),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                      .push(HeroDialogRoute(builder: (context) {
                                    return CustomPopupWidget(
                                        title: "First Order Ode",
                                        tag: "first-initial-conditions-popup",
                                        operation: "first",
                                        context: context,
                                        firstLabel: "First initial condition",
                                        firstHint: "Example: x,f(x)",
                                        firstController:
                                            firstOdeFirstInitialCondition,
                                        secondLabel: "Second initial condition",
                                        secondHint: "Example: x,f'(x)",
                                        secondController:
                                            firstOdeSecondInitialCondition);
                                  })),
                              child: Hero(
                                  tag: "first-initial-conditions-popup",
                                  child: Material(
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: textFieldDecoration(context),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 20),
                                        child: Text(
                                          "Input the Ode's initial conditions",
                                          style: TextStyle(
                                              fontFamily: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .fontFamily,
                                              color:
                                                  AppColors.customBlackTint60,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  )))),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The constant"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: textField(context, firstOdeConstant,
                            "Default is 0", "first", double.infinity),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The right hand side"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: textField(context, firstOdeRightHandSide,
                            "Default is 0", "first", double.infinity),
                      ),
                    ])),
          ),
        ),
        submitButton(context, "first", isFirstOdeFieldsReady),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: clearButton(context, firstOdeControllers, "first"),
        )
      ],
    );
  }

  Widget submitButton(
      BuildContext context, String operation, bool isFieldsReady) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Center(
            child: GestureDetector(
          onTap: isFieldsReady
              ? () {
                  switch (operation) {
                    case "first":
                      final DifferentialEquationRequest request = parseRequest(
                          "x",
                          firstOdeConstant.text == ''
                              ? "0"
                              : firstOdeConstant.text,
                          firstOdeRightHandSide.text == ''
                              ? "0"
                              : firstOdeRightHandSide.text,
                          [
                            firstOdeFirstCoefficient,
                            firstOdeSecondCoefficient
                          ],
                          [
                            firstOdeFirstInitialCondition,
                            firstOdeSecondInitialCondition
                          ]);

                      BlocProvider.of<FirstOrderDifferentialEquationBloc>(
                              context)
                          .add(FirstOrderDifferentialEquationRequested(
                              request: request));
                      break;
                    case "second":
                      final DifferentialEquationRequest request = parseRequest(
                          "x",
                          secondOdeConstant.text == ''
                              ? "0"
                              : secondOdeConstant.text,
                          secondOdeRightHandSide.text == ''
                              ? "0"
                              : secondOdeRightHandSide.text,
                          [
                            secondOdeFirstCoefficient,
                            secondOdeSecondCoefficient,
                            secondOdeThirdCoefficient
                          ],
                          [
                            secondOdeFirstInitialCondition,
                            secondOdeSecondInitialCondition,
                            secondOdeThirdInitialCondition
                          ]);

                      BlocProvider.of<SecondOrderDifferentialEquationBloc>(
                              context)
                          .add(SecondOrderDifferentialEquationRequested(
                              request: request));

                      break;
                    case "third":
                      final DifferentialEquationRequest request = parseRequest(
                          "x",
                          thirdOdeConstant.text == ''
                              ? "0"
                              : thirdOdeConstant.text,
                          thirdOdeRightHandSide.text == ''
                              ? "0"
                              : thirdOdeRightHandSide.text,
                          [
                            thirdOdeFirstCoefficient,
                            thirdOdeSecondCoefficient,
                            thirdOdeThirdCoefficient,
                            thirdOdeFourthCoefficient
                          ],
                          [
                            thirdOdeFirstInitialCondition,
                            thirdOdeSecondInitialCondition,
                            thirdOdeThirdInitialCondition,
                            thirdOdeFourthInitialCondition
                          ]);

                      BlocProvider.of<ThirdOrderDifferentialEquationBloc>(
                              context)
                          .add(ThirdOrderDifferentialEquationRequested(
                              request: request));
                  }
                }
              : () {},
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isFieldsReady
                  ? AppColors.primaryColorTint50
                  : Provider.of<ThemeManager>(context, listen: false)
                              .themeData ==
                          AppThemeData.lightTheme
                      ? AppColors.customBlackTint80
                      : AppColors.customBlackTint60,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.done_outline_outlined,
                      color: AppColors.customWhite,
                    ),
                  ),
                  Text(
                    "Get results",
                    style: TextStyle(
                      color: AppColors.customWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          Theme.of(context).textTheme.labelMedium!.fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }

  Widget clearButton(BuildContext context,
      List<TextEditingController> controllers, String operation) {
    return GestureDetector(
      onTap: () {
        if (operation == "first") {
          setState(() {
            isFirstOdeFieldsReady = false;
          });
        } else if (operation == "second") {
          setState(() {
            isSecondOdeFieldsReady = false;
          });
        } else {
          setState(() {
            isThirdOdeFieldsReady = false;
          });
        }
        for (var element in controllers) {
          element.clear();
        }
      },
      child: clearButtonDecoration(context),
    );
  }

  Widget textField(BuildContext context, TextEditingController controller,
      String hint, String operation, double width) {
    return Container(
      height: 50,
      width: width,
      decoration: textFieldDecoration(context),
      child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
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
          decoration: textFieldInputDecoration(context, hint)),
    );
  }

  DifferentialEquationRequest parseRequest(
      String variable,
      String? constant,
      String? rightHandSide,
      List<TextEditingController> coefficientControllers,
      List<TextEditingController> initialConditionControllers) {
    List<String?> coefficients = [];
    List<InitialCondition?> initialConditions = [];
    for (TextEditingController coefficientController
        in coefficientControllers) {
      coefficients.add(
          coefficientController.text == '' ? "1" : coefficientController.text);
    }

    for (TextEditingController initialConditionController
        in initialConditionControllers) {
      initialConditions.add(initialConditionController.text == ''
          ? null
          : InitialCondition(
              x: initialConditionController.text.split(",").first,
              y: initialConditionController.text.split(",").last));
    }
    return DifferentialEquationRequest(
        variable: variable,
        coefficients: coefficients,
        initialConditions: initialConditions,
        constant: constant,
        rightHandSide: rightHandSide);
  }
}

// ignore: must_be_immutable
class CustomPopupWidget extends StatefulWidget {
  final BuildContext context;
  final String operation;
  final String firstLabel;
  final String firstHint;
  final String secondLabel;
  final String secondHint;
  final String title;
  final String tag;
  final TextEditingController firstController;
  final TextEditingController secondController;
  String? thirdLabel;
  String? thirdHint;
  TextEditingController? thirdController;
  String? fourthLabel;
  String? fourthHint;
  TextEditingController? fourthController;

  CustomPopupWidget({
    Key? key,
    required this.tag,
    required this.title,
    required this.context,
    required this.operation,
    required this.firstLabel,
    required this.firstHint,
    required this.secondLabel,
    required this.secondHint,
    required this.firstController,
    required this.secondController,
    this.thirdLabel,
    this.thirdHint,
    this.thirdController,
    this.fourthLabel,
    this.fourthHint,
    this.fourthController,
  }) : super(key: key);

  @override
  _CustomPopupWidgetState createState() => _CustomPopupWidgetState();
}

class _CustomPopupWidgetState extends State<CustomPopupWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: widget.tag,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Theme.of(context).colorScheme.background,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 10),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              color: AppColors.primaryColorTint50,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .fontSize,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .fontFamily),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: inputTitle(context, widget.firstLabel),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      textField(context, widget.firstController,
                          widget.firstHint, widget.operation, double.infinity),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: inputTitle(context, widget.secondLabel),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: textField(
                            context,
                            widget.secondController,
                            widget.secondHint,
                            widget.operation,
                            double.infinity),
                      ),
                      widget.operation == "second" ||
                              widget.operation == "third"
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child:
                                      inputTitle(context, widget.thirdLabel!),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: textField(
                                      context,
                                      widget.thirdController!,
                                      widget.thirdHint!,
                                      widget.operation,
                                      double.infinity),
                                ),
                              ],
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      widget.operation == "third"
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child:
                                      inputTitle(context, widget.fourthLabel!),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: textField(
                                      context,
                                      widget.fourthController!,
                                      widget.fourthHint!,
                                      widget.operation,
                                      double.infinity),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      Padding(
                        padding: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? const EdgeInsets.only(
                                left: 40, top: 20, right: 40)
                            : const EdgeInsets.only(
                                top: 20, left: 200, right: 200),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primaryColorTint50),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              child: Center(
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    color: AppColors.customWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(BuildContext context, TextEditingController controller,
      String hint, String operation, double width) {
    return Container(
      height: 50,
      width: width,
      decoration: textFieldDecoration(context),
      child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
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
          decoration: textFieldInputDecoration(context, hint)),
    );
  }
}
