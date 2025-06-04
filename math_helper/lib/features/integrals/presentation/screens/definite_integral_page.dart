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
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/components/text_field_input_decoration.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_integral/double_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_integral/single_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_integral/triple_integral_bloc.dart';
import 'package:provider/provider.dart';

class DefiniteIntegralPage extends StatefulWidget {
  const DefiniteIntegralPage({super.key});

  @override
  State<DefiniteIntegralPage> createState() => _DefiniteIntegralPageState();
}

class _DefiniteIntegralPageState extends State<DefiniteIntegralPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  late TextEditingController singleExpressionController;
  late TextEditingController singleVariableController;
  late TextEditingController singleXLowerBoundController;
  late TextEditingController singleXUpperBoundController;

  late TextEditingController doubleExpressionController;
  late TextEditingController doubleVariableController;
  late TextEditingController doubleXLowerBoundController;
  late TextEditingController doubleXUpperBoundController;
  late TextEditingController doubleYLowerBoundController;
  late TextEditingController doubleYUpperBoundController;

  late TextEditingController tripleExpressionController;
  late TextEditingController tripleVariableController;
  late TextEditingController tripleXLowerBoundController;
  late TextEditingController tripleXUpperBoundController;
  late TextEditingController tripleYLowerBoundController;
  late TextEditingController tripleYUpperBoundController;
  late TextEditingController tripleZLowerBoundController;
  late TextEditingController tripleZUpperBoundController;

  List<TextEditingController> singleControllers = [];
  List<TextEditingController> doubleControllers = [];
  List<TextEditingController> tripleControllers = [];
  String singleIntegralLimitsText = 'lower limit: upper limit:';
  String doubleIntegralLimitsText = 'X limits: Y limits:';
  String tripleIntegralLimitsText = 'X limits: Y limits: Z limits:';

  bool isSingleFieldsReady = false;
  bool isDoubleFieldsReady = false;
  bool isTripleFieldsReady = false;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    singleExpressionController = TextEditingController();
    singleVariableController = TextEditingController();
    singleXLowerBoundController = TextEditingController();
    singleXUpperBoundController = TextEditingController();

    doubleExpressionController = TextEditingController();
    doubleVariableController = TextEditingController();
    doubleXLowerBoundController = TextEditingController();
    doubleXUpperBoundController = TextEditingController();
    doubleYLowerBoundController = TextEditingController();
    doubleYUpperBoundController = TextEditingController();

    tripleExpressionController = TextEditingController();
    tripleVariableController = TextEditingController();
    tripleXLowerBoundController = TextEditingController();
    tripleXUpperBoundController = TextEditingController();
    tripleYLowerBoundController = TextEditingController();
    tripleYUpperBoundController = TextEditingController();
    tripleZLowerBoundController = TextEditingController();
    tripleZUpperBoundController = TextEditingController();

    singleControllers = [
      singleExpressionController,
      singleVariableController,
      singleXLowerBoundController,
      singleXUpperBoundController
    ];

    doubleControllers = [
      doubleExpressionController,
      doubleVariableController,
      doubleXLowerBoundController,
      doubleXUpperBoundController,
      doubleYLowerBoundController,
      doubleYUpperBoundController
    ];

    tripleControllers = [
      tripleExpressionController,
      tripleVariableController,
      tripleXLowerBoundController,
      tripleXUpperBoundController,
      tripleYLowerBoundController,
      tripleYUpperBoundController,
      tripleZLowerBoundController,
      tripleZUpperBoundController
    ];

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    singleExpressionController.dispose();
    singleVariableController.dispose();
    singleXLowerBoundController.dispose();
    singleXUpperBoundController.dispose();
    doubleExpressionController.dispose();
    doubleVariableController.dispose();
    doubleXLowerBoundController.dispose();
    doubleXUpperBoundController.dispose();
    doubleYLowerBoundController.dispose();
    doubleYUpperBoundController.dispose();
    tripleExpressionController.dispose();
    tripleVariableController.dispose();
    tripleXLowerBoundController.dispose();
    tripleXUpperBoundController.dispose();
    tripleYLowerBoundController.dispose();
    tripleYUpperBoundController.dispose();
    tripleZLowerBoundController.dispose();
    tripleZUpperBoundController.dispose();

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
          child: singleIntegralScreen(context),
        ),
        Center(
          child: doubleIntegralScreen(context),
        ),
        Center(
          child: tripleIntegralScreen(context),
        ),
      ]),
    );
  }

  Widget singleIntegralScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<SingleIntegralBloc, SingleIntegralState>(
        listener: (context, state) {
          if (state is SingleIntegralFailure) {
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
          if (state is SingleIntegralInitial) {
            return singleIntegralInitial(context);
          } else if (state is SingleIntegralLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is SingleIntegralSuccess) {
            return successWidget(
                context,
                "Single Integral",
                state.integralResponse.integral,
                state.integralResponse.result,
                "single");
          } else if (state is SingleIntegralFailure) {
            return singleIntegralInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget doubleIntegralScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<DoubleIntegralBloc, DoubleIntegralState>(
        listener: (context, state) {
          if (state is DoubleIntegralFailure) {
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
          if (state is DoubleIntegralInitial) {
            return doubleIntegralInitial(context);
          } else if (state is DoubleIntegralLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is DoubleIntegralSuccess) {
            return successWidget(
                context,
                "Double Integral",
                state.integralResponse.integral,
                state.integralResponse.result,
                "double");
          } else if (state is DoubleIntegralFailure) {
            return doubleIntegralInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget tripleIntegralScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<TripleIntegralBloc, TripleIntegralState>(
        listener: (context, state) {
          if (state is TripleIntegralFailure) {
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
          if (state is TripleIntegralInitial) {
            return tripleIntegralInitial(context);
          } else if (state is TripleIntegralLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is TripleIntegralSuccess) {
            return successWidget(context, "Triple Integral",
                state.response.integral, state.response.result, "triple");
          } else if (state is TripleIntegralFailure) {
            return tripleIntegralInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget singleIntegralInitial(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Single Integral",
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
                        child: inputTitle(context, "The expression"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: textField(
                            context,
                            singleExpressionController,
                            "Input the expression to integrate",
                            "single",
                            double.infinity,
                            singleControllers.sublist(0, 2)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The variable"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: textField(
                            context,
                            singleVariableController,
                            "Input the used variable",
                            "single",
                            double.infinity,
                            singleControllers.sublist(0, 2)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The limits"),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                      .push(HeroDialogRoute(builder: (context) {
                                    return SingleIntegralPopup(
                                      lowerLimitController:
                                          singleXLowerBoundController,
                                      upperLimitController:
                                          singleXUpperBoundController,
                                      updateVariable:
                                          updateSingleIntegralLimitsText,
                                    );
                                  })),
                              child: Hero(
                                  tag: "single",
                                  child: Material(
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: textFieldDecoration(context),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 20),
                                          child: Text(
                                            singleIntegralLimitsText,
                                            style: TextStyle(
                                                fontFamily: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .fontFamily,
                                                color:
                                                    AppColors.customBlackTint60,
                                                fontSize: 14),
                                          )),
                                    ),
                                  )))),
                    ])),
          ),
        ),
        submitButton(
          context,
          "single",
          isSingleFieldsReady,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: clearButton(context, singleControllers, "single"),
        )
      ],
    );
  }

  Widget doubleIntegralInitial(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Double Integral",
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
                        child: inputTitle(context, "The expression"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: textField(
                            context,
                            doubleExpressionController,
                            "Input the expression to integrate",
                            "double",
                            double.infinity,
                            doubleControllers.sublist(0, 2)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The variables"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: textField(
                            context,
                            doubleVariableController,
                            "example: var1,var2",
                            "double",
                            double.infinity,
                            doubleControllers.sublist(0, 2)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The limits"),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                      .push(HeroDialogRoute(builder: (context) {
                                    return DoubleIntegralPopup(
                                      xLowerLimit: doubleXLowerBoundController,
                                      xUpperLimit: doubleXUpperBoundController,
                                      yLowerLimit: doubleYLowerBoundController,
                                      yUpperLimit: doubleYUpperBoundController,
                                      updateVariable:
                                          updateDoubleIntegralLimitsText,
                                    );
                                  })),
                              child: Hero(
                                  tag: "double",
                                  child: Material(
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: textFieldDecoration(context),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 20),
                                          child: Text(
                                            doubleIntegralLimitsText,
                                            style: TextStyle(
                                                fontFamily: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .fontFamily,
                                                color:
                                                    AppColors.customBlackTint60,
                                                fontSize: 14),
                                          )),
                                    ),
                                  )))),
                    ])),
          ),
        ),
        submitButton(
          context,
          "double",
          isDoubleFieldsReady,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: clearButton(context, doubleControllers, "double"),
        )
      ],
    );
  }

  Widget tripleIntegralInitial(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Triple Integral",
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
                        child: inputTitle(context, "The expression"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: textField(
                            context,
                            tripleExpressionController,
                            "Input the expression to integrate",
                            "triple",
                            double.infinity,
                            tripleControllers.sublist(0, 2)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The variables"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: textField(
                            context,
                            tripleVariableController,
                            "example: var1,var2,var3",
                            "triple",
                            double.infinity,
                            tripleControllers.sublist(0, 2)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: inputTitle(context, "The limits"),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                      .push(HeroDialogRoute(builder: (context) {
                                    return TripleIntegralPopup(
                                      xLowerLimit: tripleXLowerBoundController,
                                      xUpperLimit: tripleXUpperBoundController,
                                      yLowerLimit: tripleYLowerBoundController,
                                      yUpperLimit: tripleYUpperBoundController,
                                      zLowerLimit: tripleZLowerBoundController,
                                      zUpperLimit: tripleZUpperBoundController,
                                      updateVariable:
                                          updateTripleIntegralLimitsText,
                                    );
                                  })),
                              child: Hero(
                                  tag: "triple",
                                  child: Material(
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: textFieldDecoration(context),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 20),
                                          child: Text(
                                            tripleIntegralLimitsText,
                                            style: TextStyle(
                                                fontFamily: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .fontFamily,
                                                color:
                                                    AppColors.customBlackTint60,
                                                fontSize: 14),
                                          )),
                                    ),
                                  )))),
                    ])),
          ),
        ),
        submitButton(
          context,
          "triple",
          isTripleFieldsReady,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: clearButton(context, tripleControllers, "triple"),
        )
      ],
    );
  }

  Widget clearButton(BuildContext context,
      List<TextEditingController> controllers, String operation) {
    return GestureDetector(
      onTap: () {
        for (var element in controllers) {
          element.clear();
        }
        if (operation == "single") {
          updateSingleIntegralLimitsText('lower limit: upper limit:');
          setState(() {
            isSingleFieldsReady = false;
          });
        } else if (operation == "double") {
          updateDoubleIntegralLimitsText('X limits: Y limits:');
          setState(() {
            isDoubleFieldsReady = false;
          });
        } else {
          updateTripleIntegralLimitsText('X limits: Y limits: Z limits:');
          setState(() {
            isTripleFieldsReady = false;
          });
        }
      },
      child: clearButtonDecoration(context),
    );
  }

  Widget successWidget(BuildContext context, String title, String integral,
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
                    integralResult(
                        context, integral, result, "The Integral result"),
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
            child: integralResetButton(context, operation),
          ),
        ],
      ),
    );
  }

  Widget integralResult(
      BuildContext context, String integral, String result, String title) {
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
                    context, "result", r"""$$""" + integral + r"""$$"""))),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TeXView(
                child: teXViewWidget(
                    context, "result", r"""$$""" + result + r"""$$"""))),
      ],
    );
  }

  Widget integralResetButton(BuildContext context, String operation) {
    return GestureDetector(
      onTap: () {
        if (operation == "single") {
          BlocProvider.of<SingleIntegralBloc>(context)
              .add(const SingleIntegralReset());
        } else if (operation == "double") {
          BlocProvider.of<DoubleIntegralBloc>(context)
              .add(const DoubleIntegralReset());
        } else {
          BlocProvider.of<TripleIntegralBloc>(context)
              .add(const TripleIntegralReset());
        }
      },
      child: resetButton(context),
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
                    case "single":
                      IntegralRequest request = parseRequest(
                          [singleXUpperBoundController],
                          [singleXLowerBoundController],
                          singleExpressionController.text,
                          [singleVariableController.text]);

                      BlocProvider.of<SingleIntegralBloc>(context)
                          .add(SingleIntegralRequested(request: request));
                      break;

                    case "double":
                      IntegralRequest request = parseRequest([
                        doubleXUpperBoundController,
                        doubleYUpperBoundController
                      ], [
                        doubleXLowerBoundController,
                        doubleYLowerBoundController
                      ], doubleExpressionController.text,
                          doubleVariableController.text.split(','));
                      BlocProvider.of<DoubleIntegralBloc>(context)
                          .add(DoubleIntegralRequested(request: request));

                      break;

                    case "triple":
                      IntegralRequest request = parseRequest(
                          [
                            tripleXUpperBoundController,
                            tripleYUpperBoundController,
                            tripleZUpperBoundController
                          ],
                          [
                            tripleXLowerBoundController,
                            tripleYLowerBoundController,
                            tripleZLowerBoundController
                          ],
                          tripleExpressionController.text,
                          [tripleVariableController.text]);
                      BlocProvider.of<TripleIntegralBloc>(context)
                          .add(TripleIntegralRequested(request: request));

                      break;
                  }
                }
              : () {},
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isFieldsReady
                    ? AppColors.primaryColorTint50
                    : AppColors.customBlackTint80),
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
        ),
      ),
    );
  }

  IntegralRequest parseRequest(
      List<TextEditingController> upperLimitControllers,
      List<TextEditingController> lowerLimitControllers,
      String expression,
      List<String> variables) {
    List<IntegralLimits> limits = [];
    for (var i = 0; i < upperLimitControllers.length; i++) {
      limits.add(IntegralLimits(
          lowerLimit: parseValue(lowerLimitControllers[i].text == ''
              ? "-oo"
              : lowerLimitControllers[i].text),
          upperLimit: parseValue(upperLimitControllers[i].text == ''
              ? "oo"
              : upperLimitControllers[i].text)));
    }
    return IntegralRequest(
        expression: expression, variables: variables, limits: limits);
  }

  dynamic parseValue(String input) {
    int? tryInt = int.tryParse(input);
    if (tryInt != null) {
      return tryInt;
    }

    double? tryDouble = double.tryParse(input);
    if (tryDouble != null) {
      return tryDouble;
    }

    return input;
  }

  void updateSingleIntegralLimitsText(String value) {
    setState(() {
      singleIntegralLimitsText = value;
    });
  }

  void updateDoubleIntegralLimitsText(String value) {
    setState(() {
      doubleIntegralLimitsText = value;
    });
  }

  void updateTripleIntegralLimitsText(String value) {
    setState(() {
      tripleIntegralLimitsText = value;
    });
  }

  Widget textField(
      BuildContext context,
      TextEditingController controller,
      String hint,
      String operation,
      double width,
      List<TextEditingController> controllers) {
    return Container(
      height: 50,
      width: width,
      decoration: textFieldDecoration(context),
      child: TextField(
          onChanged: (value) {
            if (allControllersHaveText(controllers)) {
              switch (operation) {
                case "single":
                  setState(() {
                    isSingleFieldsReady = true;
                  });

                  break;

                case "double":
                  setState(() {
                    isDoubleFieldsReady = true;
                  });
                default:
                  setState(() {
                    isTripleFieldsReady = true;
                  });
              }
            } else {
              switch (operation) {
                case "single":
                  setState(() {
                    isSingleFieldsReady = false;
                  });

                  break;

                case "double":
                  setState(() {
                    isDoubleFieldsReady = false;
                  });
                default:
                  setState(() {
                    isTripleFieldsReady = false;
                  });
              }
            }
          },
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

  bool allControllersHaveText(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
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

class SingleIntegralPopup extends StatefulWidget {
  final TextEditingController lowerLimitController;
  final TextEditingController upperLimitController;
  final Function(String) updateVariable;

  const SingleIntegralPopup(
      {super.key,
      required this.lowerLimitController,
      required this.upperLimitController,
      required this.updateVariable});

  @override
  State<SingleIntegralPopup> createState() => _SingleIntegralPopupState();
}

class _SingleIntegralPopupState extends State<SingleIntegralPopup> {
  bool toChange = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: "single",
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
                        "Single Integral",
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
                      child: inputTitle(context, "Lower limit"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    textField(
                        context,
                        widget.lowerLimitController,
                        "input the lower limit of the integral",
                        "single",
                        double.infinity),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: inputTitle(context, "Upper limit"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: textField(
                          context,
                          widget.upperLimitController,
                          "input the upper limit of the integral",
                          "single",
                          double.infinity),
                    ),
                    Padding(
                      padding: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? const EdgeInsets.only(left: 40, top: 20, right: 40)
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
                  ],
                ),
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
          onChanged: (value) {
            widget.updateVariable(
                "lower limit: ${widget.lowerLimitController.text} upper limit: ${widget.upperLimitController.text}");
          },
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

class DoubleIntegralPopup extends StatefulWidget {
  final TextEditingController xLowerLimit;
  final TextEditingController xUpperLimit;
  final TextEditingController yLowerLimit;
  final TextEditingController yUpperLimit;
  final Function(String) updateVariable;

  const DoubleIntegralPopup(
      {super.key,
      required this.xLowerLimit,
      required this.xUpperLimit,
      required this.yLowerLimit,
      required this.yUpperLimit,
      required this.updateVariable});

  @override
  State<DoubleIntegralPopup> createState() => _DoubleIntegralPopupState();
}

class _DoubleIntegralPopupState extends State<DoubleIntegralPopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: "double",
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
                        "Double Integral",
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
                      child: inputTitle(context, "First limits"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textField(
                            context, widget.xLowerLimit, "y", "double", 130),
                        const SizedBox(
                          width: 20,
                        ),
                        textField(
                            context, widget.xUpperLimit, "x", "double", 130),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: inputTitle(context, "Second limits"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textField(
                            context, widget.yLowerLimit, "x", "double", 130),
                        const SizedBox(
                          width: 20,
                        ),
                        textField(
                            context, widget.yUpperLimit, "y", "double", 130),
                      ],
                    ),
                    Padding(
                      padding: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? const EdgeInsets.only(left: 40, top: 20, right: 40)
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
                  ],
                ),
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
          onChanged: (value) {
            widget.updateVariable(
                "X limits: (${widget.xLowerLimit.text},${widget.xUpperLimit.text}) Y limits: (${widget.yLowerLimit.text},${widget.yUpperLimit.text})");
          },
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

class TripleIntegralPopup extends StatefulWidget {
  final TextEditingController xLowerLimit;
  final TextEditingController xUpperLimit;
  final TextEditingController yLowerLimit;
  final TextEditingController yUpperLimit;
  final TextEditingController zLowerLimit;
  final TextEditingController zUpperLimit;
  final Function(String) updateVariable;

  const TripleIntegralPopup(
      {super.key,
      required this.xLowerLimit,
      required this.xUpperLimit,
      required this.yLowerLimit,
      required this.yUpperLimit,
      required this.updateVariable,
      required this.zLowerLimit,
      required this.zUpperLimit});

  @override
  State<TripleIntegralPopup> createState() => _TripleIntegralPopupState();
}

class _TripleIntegralPopupState extends State<TripleIntegralPopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: "triple",
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
                        "Triple Integral",
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
                      child: inputTitle(context, "First limits"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textField(
                            context, widget.xLowerLimit, "y", "triple", 130),
                        const SizedBox(
                          width: 20,
                        ),
                        textField(
                            context, widget.xUpperLimit, "x", "triple", 130),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: inputTitle(context, "Second limits"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textField(
                            context, widget.yLowerLimit, "x", "triple", 130),
                        const SizedBox(
                          width: 20,
                        ),
                        textField(
                            context, widget.yUpperLimit, "y", "triple", 130),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: inputTitle(context, "Third limits"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textField(
                            context, widget.zLowerLimit, "x", "triple", 130),
                        const SizedBox(
                          width: 20,
                        ),
                        textField(
                            context, widget.zUpperLimit, "y", "triple", 130),
                      ],
                    ),
                    Padding(
                      padding: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? const EdgeInsets.only(left: 40, top: 20, right: 40)
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
                  ],
                ),
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
          onChanged: (value) {
            widget.updateVariable(
                "X limits: (${widget.xLowerLimit.text},${widget.xUpperLimit.text}) Y limits: (${widget.yLowerLimit.text},${widget.yUpperLimit.text}) Z limits: (${widget.zLowerLimit.text},${widget.zUpperLimit.text})");
          },
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
