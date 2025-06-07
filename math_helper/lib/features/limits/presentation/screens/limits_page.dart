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
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/components/text_field_input_decoration.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/limits/data/models/limit_request.dart';
import 'package:math_helper/features/limits/presentation/bloc/double_limit/double_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/bloc/single_limit/single_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/bloc/triple_limit/triple_limit_bloc.dart';
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

  List<TextEditingController> singleControllers = [];
  List<TextEditingController> doubleControllers = [];
  List<TextEditingController> tripleControllers = [];
  String singleLimitText = 'limit: sign:';
  String doubleLimitText = 'X limit: Y limit:';
  String tripleLimitText = 'X limit: Y limit: Z limit:';

  bool isSingleFieldsReady = false;
  bool isDoubleFieldsReady = false;
  bool isTripleFieldsReady = false;

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

    singleControllers = [
      singleExpressionController,
      singleVariableController,
      singleXBoundController,
      singleXSignController
    ];

    doubleControllers = [
      doubleExpressionController,
      doubleVariableController,
      doubleXBoundController,
      doubleXSignController,
      doubleYBoundController,
      doubleYSignController
    ];

    tripleControllers = [
      tripleExpressionController,
      tripleVariableController,
      tripleXBoundController,
      tripleXSignController,
      tripleYBoundController,
      tripleYSignController,
      tripleZBoundController,
      tripleZSignController
    ];

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
          child: singleLimitScreen(context),
        ),
        Center(
          child: doubleLimitScreen(context),
        ),
        Center(
          child: tripleLimitScreen(context),
        ),
      ]),
    );
  }

  Widget singleLimitScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<SingleLimitBloc, SingleLimitState>(
        listener: (context, state) {
          if (state is SingleLimitFailure) {
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
          if (state is SingleLimitInitial) {
            return singleLimitInitial(context);
          } else if (state is SingleLimitLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is SingleLimitSuccess) {
            return successWidget(context, "Single Limit", state.response.limit,
                state.response.result, "single");
          } else if (state is SingleLimitFailure) {
            return singleLimitInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget doubleLimitScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<DoubleLimitBloc, DoubleLimitState>(
        listener: (context, state) {
          if (state is DoubleLimitFailure) {
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
          if (state is DoubleLimitInitial) {
            return doubleLimitInitial(context);
          } else if (state is DoubleLimitLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is DoubleLimitSuccess) {
            return successWidget(context, "Double Limit", state.response.limit,
                state.response.result, "double");
          } else if (state is DoubleLimitFailure) {
            return doubleLimitInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget tripleLimitScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<TripleLimitBloc, TripleLimitState>(
        listener: (context, state) {
          if (state is TripleLimitFailure) {
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
          if (state is TripleLimitInitial) {
            return tripleLimitInitial(context);
          } else if (state is TripleLimitLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is TripleLimitSuccess) {
            return successWidget(context, "Triple Limit", state.response.limit,
                state.response.result, "triple");
          } else if (state is TripleLimitFailure) {
            return tripleLimitInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget singleLimitInitial(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Single Limit",
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
                                    return SingleLimitPopup(
                                      xLimit: singleXBoundController,
                                      xSign: singleXSignController,
                                      updateVariable:
                                          updateSingleLimitLimitsText,
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
                                            singleLimitText,
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

  Widget doubleLimitInitial(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Double Limit",
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
                                    return DoubleLimitPopup(
                                      xLimit: doubleXBoundController,
                                      xSign: doubleXSignController,
                                      yLimit: doubleYBoundController,
                                      ySign: doubleYSignController,
                                      updateVariable:
                                          updateDoubleLimitLimitsText,
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
                                            doubleLimitText,
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

  Widget tripleLimitInitial(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Triple Limit",
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
                                    return TripleLimitPopup(
                                      xLimit: tripleXBoundController,
                                      xSign: tripleXSignController,
                                      yLimit: tripleYBoundController,
                                      ySign: tripleYSignController,
                                      zLimit: tripleZBoundController,
                                      zSign: tripleZSignController,
                                      updateVariable:
                                          updateTripleLimitLimitsText,
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
                                            tripleLimitText,
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
          updateSingleLimitLimitsText('lower limit: upper limit:');
          setState(() {
            isSingleFieldsReady = false;
          });
        } else if (operation == "double") {
          updateDoubleLimitLimitsText('X limits: Y limits:');
          setState(() {
            isDoubleFieldsReady = false;
          });
        } else {
          updateTripleLimitLimitsText('X limits: Y limits: Z limits:');
          setState(() {
            isTripleFieldsReady = false;
          });
        }
      },
      child: clearButtonDecoration(context),
    );
  }

  Widget successWidget(BuildContext context, String title, String limit,
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
                    limitResult(context, limit, result, "The Limit result"),
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
            child: limitResetButton(context, operation),
          ),
        ],
      ),
    );
  }

  Widget limitResult(
      BuildContext context, String limit, String result, String title) {
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
                    context, "result", r"""$$""" + limit + r"""$$"""))),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TeXView(
                child: teXViewWidget(
                    context, "result", r"""$$""" + result + r"""$$"""))),
      ],
    );
  }

  Widget limitResetButton(BuildContext context, String operation) {
    return GestureDetector(
      onTap: () {
        if (operation == "single") {
          BlocProvider.of<SingleLimitBloc>(context)
              .add(const SingleLimitReset());
        } else if (operation == "double") {
          BlocProvider.of<DoubleLimitBloc>(context)
              .add(const DoubleLimitReset());
        } else {
          BlocProvider.of<TripleLimitBloc>(context)
              .add(const TripleLimitReset());
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
                      LimitRequest request = parseRequest(
                          [singleXSignController],
                          [singleXBoundController],
                          singleExpressionController.text,
                          [singleVariableController.text]);

                      BlocProvider.of<SingleLimitBloc>(context)
                          .add(SingleLimitRequested(request: request));
                      break;

                    case "double":
                      LimitRequest request = parseRequest(
                          [doubleXSignController, doubleYSignController],
                          [doubleXBoundController, doubleYBoundController],
                          doubleExpressionController.text,
                          doubleVariableController.text.split(','));
                      BlocProvider.of<DoubleLimitBloc>(context)
                          .add(DoubleLimitRequested(request: request));

                      break;

                    case "triple":
                      LimitRequest request = parseRequest(
                          [
                            tripleXSignController,
                            tripleYSignController,
                            tripleZSignController
                          ],
                          [
                            tripleXBoundController,
                            tripleYBoundController,
                            tripleZBoundController
                          ],
                          tripleExpressionController.text,
                          [tripleVariableController.text]);
                      BlocProvider.of<TripleLimitBloc>(context)
                          .add(TripleLimitRequested(request: request));

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

  LimitRequest parseRequest(
      List<TextEditingController> signControllers,
      List<TextEditingController> valueControllers,
      String expression,
      List<String> variables) {
    List<Bound> limits = [];
    for (var i = 0; i < signControllers.length; i++) {
      limits.add(Bound(
          value: parseValue(
              valueControllers[i].text == '' ? "0" : valueControllers[i].text),
          sign: parseValue(
              signControllers[i].text == '' ? "+" : signControllers[i].text)));
    }
    return LimitRequest(
        expression: expression, variables: variables, bounds: limits);
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

  void updateSingleLimitLimitsText(String value) {
    setState(() {
      singleLimitText = value;
    });
  }

  void updateDoubleLimitLimitsText(String value) {
    setState(() {
      doubleLimitText = value;
    });
  }

  void updateTripleLimitLimitsText(String value) {
    setState(() {
      tripleLimitText = value;
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
  
  loadingComponent(BuildContext context) {}
  
  inputTitle(BuildContext context, String s) {}
  
  resetButton(BuildContext context) {}
}

class SingleLimitPopup extends StatefulWidget {
  final TextEditingController xLimit;
  final TextEditingController xSign;
  final Function(String) updateVariable;

  const SingleLimitPopup(
      {super.key,
      required this.xLimit,
      required this.xSign,
      required this.updateVariable});

  @override
  State<SingleLimitPopup> createState() => _SingleLimitPopupState();
}

class _SingleLimitPopupState extends State<SingleLimitPopup> {
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
                        "Single Limit",
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
                      child: inputTitle(context, "Limit"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    textField(context, widget.xLimit, "input the limit",
                        "single", double.infinity),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: inputTitle(context, "Sign"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: textField(context, widget.xSign, "sign (+/-)",
                          "single", double.infinity),
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
                "lower limit: ${widget.xLimit.text} upper limit: ${widget.xSign.text}");
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
  
  inputTitle(BuildContext context, String s) {}
}

class DoubleLimitPopup extends StatefulWidget {
  final TextEditingController xLimit;
  final TextEditingController xSign;
  final TextEditingController yLimit;
  final TextEditingController ySign;
  final Function(String) updateVariable;

  const DoubleLimitPopup(
      {super.key,
      required this.xLimit,
      required this.xSign,
      required this.yLimit,
      required this.ySign,
      required this.updateVariable});

  @override
  State<DoubleLimitPopup> createState() => _DoubleLimitPopupState();
}

class _DoubleLimitPopupState extends State<DoubleLimitPopup> {
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
                        "Double Limit",
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
                            context, widget.xLimit, "limit", "double", 130),
                        const SizedBox(
                          width: 20,
                        ),
                        textField(
                            context, widget.xSign, "sign (+/-)", "double", 130),
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
                            context, widget.yLimit, "limit", "double", 130),
                        const SizedBox(
                          width: 20,
                        ),
                        textField(
                            context, widget.ySign, "sign (+/-)", "double", 130),
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
                "X limit: (${widget.xLimit.text},${widget.xSign.text}) Y limit: (${widget.yLimit.text},${widget.ySign.text})");
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
  
  inputTitle(BuildContext context, String s) {}
}

class TripleLimitPopup extends StatefulWidget {
  final TextEditingController xLimit;
  final TextEditingController xSign;
  final TextEditingController yLimit;
  final TextEditingController ySign;
  final TextEditingController zLimit;
  final TextEditingController zSign;
  final Function(String) updateVariable;

  const TripleLimitPopup(
      {super.key,
      required this.xLimit,
      required this.xSign,
      required this.yLimit,
      required this.ySign,
      required this.updateVariable,
      required this.zLimit,
      required this.zSign});

  @override
  State<TripleLimitPopup> createState() => _TripleLimitPopupState();
}

class _TripleLimitPopupState extends State<TripleLimitPopup> {
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
                        "Triple Limit",
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
                      child: inputTitle(context, "First limit"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textField(
                            context, widget.xLimit, "limit", "triple", 130),
                        const SizedBox(
                          width: 20,
                        ),
                        textField(
                            context, widget.xSign, "sign (+/-)", "triple", 130),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: inputTitle(context, "Second limit"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textField(
                            context, widget.yLimit, "limit", "triple", 130),
                        const SizedBox(
                          width: 20,
                        ),
                        textField(
                            context, widget.ySign, "sign (+/-)", "triple", 130),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: inputTitle(context, "Third limit"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textField(
                            context, widget.zLimit, "limit", "triple", 130),
                        const SizedBox(
                          width: 20,
                        ),
                        textField(
                            context, widget.zSign, "sign (+/-)", "triple", 130),
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
                "X limit: (${widget.xLimit.text},${widget.xSign.text}) Y limit: (${widget.yLimit.text},${widget.ySign.text}) Z limit: (${widget.zLimit.text},${widget.zSign.text})");
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
  
  inputTitle(BuildContext context, String s) {}
}
