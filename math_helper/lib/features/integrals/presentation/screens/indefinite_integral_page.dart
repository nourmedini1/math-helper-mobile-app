import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/clear_button_decoration.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/components/input_title.dart';
import 'package:math_helper/core/ui/components/loading_component.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/components/text_field_input_decoration.dart';
import 'package:math_helper/core/ui/theme_manager.dart';

import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_primitive/double_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_primitive/single_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_primitive/triple_primitive_bloc.dart';
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

  List<TextEditingController> singleControllers = [];
  List<TextEditingController> doubleControllers = [];
  List<TextEditingController> tripleControllers = [];

  bool isSingleFieldsReady = false;
  bool isDoubleFieldsReady = false;
  bool isTripleFieldsReady = false;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    singleExpressionController = TextEditingController();
    singleVariableController = TextEditingController();

    doubleExpressionController = TextEditingController();
    doubleVariableController = TextEditingController();

    tripleExpressionController = TextEditingController();
    tripleVariableController = TextEditingController();

    singleControllers = [
      singleExpressionController,
      singleVariableController,
    ];

    doubleControllers = [
      doubleExpressionController,
      doubleVariableController,
    ];

    tripleControllers = [
      tripleExpressionController,
      tripleVariableController,
    ];

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
          child: singlePrimitiveScreen(context),
        ),
        Center(
          child: doublePrimitiveScreen(context),
        ),
        Center(
          child: triplePrimitiveScreen(context),
        ),
      ]),
    );
  }

  Widget singlePrimitiveScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<SinglePrimitiveBloc, SinglePrimitiveState>(
        listener: (context, state) {
          if (state is SinglePrimitiveFailure) {
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
          if (state is SinglePrimitiveInitial) {
            return singlePrimitiveInitial(context);
          } else if (state is SinglePrimitiveLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is SinglePrimitiveSuccess) {
            return successWidget(
                context,
                "Single Primitive",
                state.integralResponse.integral,
                state.integralResponse.result,
                "single");
          } else if (state is SinglePrimitiveFailure) {
            return singlePrimitiveInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget doublePrimitiveScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<DoublePrimitiveBloc, DoublePrimitiveState>(
        listener: (context, state) {
          if (state is DoublePrimitiveFailure) {
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
          if (state is DoublePrimitiveInitial) {
            return doublePrimitiveInitial(context);
          } else if (state is DoublePrimitiveLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is DoublePrimitiveSuccess) {
            return successWidget(
                context,
                "Double Primitive",
                state.integralResponse.integral,
                state.integralResponse.result,
                "double");
          } else if (state is DoublePrimitiveFailure) {
            return doublePrimitiveInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget triplePrimitiveScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<TriplePrimitiveBloc, TriplePrimitiveState>(
        listener: (context, state) {
          if (state is TriplePrimitiveFailure) {
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
          if (state is TriplePrimitiveInitial) {
            return triplePrimitiveInitial(context);
          } else if (state is TriplePrimitiveLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is TriplePrimitiveSuccess) {
            return successWidget(
                context,
                "Triple Primitive",
                state.integralResponse.integral,
                state.integralResponse.result,
                "triple");
          } else if (state is TriplePrimitiveFailure) {
            return triplePrimitiveInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget singlePrimitiveInitial(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Single Primitive",
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
          child: clearButton(context, singleControllers),
        )
      ],
    );
  }

  Widget doublePrimitiveInitial(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Double Primitive",
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
          child: clearButton(context, doubleControllers),
        )
      ],
    );
  }

  Widget triplePrimitiveInitial(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Triple Primitive",
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
          child: clearButton(context, tripleControllers),
        )
      ],
    );
  }

  Widget clearButton(
    BuildContext context,
    List<TextEditingController> controllers,
  ) {
    return GestureDetector(
      onTap: () {
        for (var element in controllers) {
          element.clear();
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
                    primitiveResult(
                        context, integral, result, "The Primitive result"),
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
            child: primitiveResetButton(context, operation),
          ),
        ],
      ),
    );
  }

  Widget primitiveResult(
      BuildContext context, String primitive, String result, String title) {
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
                    context, "result", r"""$$""" + primitive + r"""$$"""))),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TeXView(
                child: teXViewWidget(
                    context, "result", r"""$$""" + result + r"""$$"""))),
      ],
    );
  }

  Widget primitiveResetButton(BuildContext context, String operation) {
    return GestureDetector(
      onTap: () {
        if (operation == "single") {
          BlocProvider.of<SinglePrimitiveBloc>(context)
              .add(const SinglePrimitiveReset());
        } else if (operation == "double") {
          BlocProvider.of<DoublePrimitiveBloc>(context)
              .add(const DoublePrimitiveReset());
        } else {
          BlocProvider.of<TriplePrimitiveBloc>(context)
              .add(const TriplePrimitiveReset());
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
                      IntegralRequest request = IntegralRequest(
                          expression: singleExpressionController.text,
                          variables: singleVariableController.text.split(","));

                      BlocProvider.of<SinglePrimitiveBloc>(context)
                          .add(SinglePrimitiveRequested(request: request));
                      break;

                    case "double":
                      IntegralRequest request = IntegralRequest(
                          expression: doubleExpressionController.text,
                          variables: doubleVariableController.text.split(","));
                      BlocProvider.of<DoublePrimitiveBloc>(context)
                          .add(DoublePrimitiveRequested(request: request));

                      break;

                    case "triple":
                      IntegralRequest request = IntegralRequest(
                          expression: tripleExpressionController.text,
                          variables: tripleVariableController.text.split(","));
                      BlocProvider.of<TriplePrimitiveBloc>(context)
                          .add(TriplePrimitiveRequested(request: request));

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
