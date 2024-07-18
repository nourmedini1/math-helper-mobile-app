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
import 'package:math_helper/features/derivatives/data/models/derivative_request.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/numeric_derivative/numeric_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/symbolic_derivative/symbolic_derivative_bloc.dart';
import 'package:provider/provider.dart';

class DerivativesPage extends StatefulWidget {
  const DerivativesPage({super.key});

  @override
  State<DerivativesPage> createState() => _DerivativesPageState();
}

class _DerivativesPageState extends State<DerivativesPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  late TextEditingController symbolicExpressionController;
  late TextEditingController numericExpressionController;
  late TextEditingController symbolicVariableController;
  late TextEditingController numericVariableController;
  late TextEditingController symbolicOrderController;
  late TextEditingController numericOrderController;
  late TextEditingController derivingPointController;
  bool isSymbolicFieldsReady = false;
  bool isNumericFieldsReady = false;
  bool isPartialSymbolic = false;
  bool isPartialNumeric = false;
  List<TextEditingController> symbolicControllers = [];
  List<TextEditingController> numericControllers = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    symbolicExpressionController = TextEditingController();
    numericExpressionController = TextEditingController();
    symbolicVariableController = TextEditingController();
    numericVariableController = TextEditingController();
    symbolicOrderController = TextEditingController();
    numericOrderController = TextEditingController();
    derivingPointController = TextEditingController();
    symbolicControllers = [
      symbolicExpressionController,
      symbolicVariableController,
      symbolicOrderController,
    ];
    numericControllers = [
      numericExpressionController,
      numericVariableController,
      numericOrderController,
      derivingPointController,
    ];
  }

  @override
  void dispose() {
    tabController.dispose();
    symbolicExpressionController.dispose();
    numericExpressionController.dispose();
    symbolicVariableController.dispose();
    numericVariableController.dispose();
    symbolicOrderController.dispose();
    numericOrderController.dispose();
    derivingPointController.dispose();
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
          Center(
            child: symbolicScreen(context),
          ),
          Center(
            child: numericScreen(context),
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
                      title: 'Symbolic',
                      icon: Icon(Icons.bar_chart, size: 15),
                      fontSize: 14,
                    ),
                    TabBarItem(
                        fontSize: 14,
                        title: 'Numeric',
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

  Widget numericScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<NumericDerivativeBloc, NumericDerivativeState>(
        listener: (context, state) {
          if (state is NumericDerivativeFailure) {
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
          if (state is NumericDerivativeInitial) {
            return numericInitialWidget(context);
          } else if (state is NumericDerivativeLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is NumericDerivativeSuccess) {
            return numericSuccessWidget(context, "Numeric Derivative",
                state.response.derivative, state.response.result.toString());
          } else if (state is NumericDerivativeFailure) {
            return numericInitialWidget(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget symbolicScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<SymbolicDerivativeBloc, SymbolicDerivativeState>(
        listener: (context, state) {
          if (state is SymbolicDerivativeFailure) {
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
          if (state is SymbolicDerivativeInitial) {
            return symbolicInitialWidget(context);
          } else if (state is SymbolicDerivativeLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is SymbolicDerivativeSuccess) {
            return symbolicSuccessWidget(context, "Symbolic Derivative",
                state.response.derivative, state.response.result.toString());
          } else if (state is SymbolicDerivativeFailure) {
            return symbolicInitialWidget(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget numericInitialWidget(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Numeric Derivative",
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
                          numericExpressionController,
                          "Example: cos(x)/(1 + sin(x))",
                          "numeric",
                          numericControllers,
                          TextInputType.text),
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
                          numericVariableController,
                          " The variable used, example: x",
                          "numeric",
                          numericControllers,
                          TextInputType.text),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child:
                          inputTitle(context, "The order of differentiation"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(
                          context,
                          numericOrderController,
                          "Must be 1 or higher",
                          "numeric",
                          numericControllers,
                          TextInputType.number),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: inputTitle(context, "The deriving point"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(
                          context,
                          derivingPointController,
                          "The point at which the derivative is calculated",
                          "numeric",
                          numericControllers,
                          TextInputType.text),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Partial derivative ? ",
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .fontFamily,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .fontSize,
                              color: Provider.of<ThemeManager>(context,
                                              listen: false)
                                          .themeData ==
                                      AppThemeData.lightTheme
                                  ? AppColors.customBlack
                                  : AppColors.customBlackTint80,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Switch(
                            activeColor: AppColors.primaryColor,
                            inactiveThumbColor: Provider.of<ThemeManager>(
                                            context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlackTint60
                                : AppColors.customBlackTint90,
                            value: isPartialNumeric,
                            onChanged: (value) {
                              setState(() {
                                isPartialNumeric = !isPartialNumeric;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
        submitButton(context, "numeric", isNumericFieldsReady),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: clearButton(context, numericControllers, "numeric"),
        )
      ],
    );
  }

  Widget symbolicInitialWidget(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Symbolic Derivative",
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
                          symbolicExpressionController,
                          "Example: cos(x)/(1 + sin(x))",
                          "symbolic",
                          symbolicControllers,
                          TextInputType.text),
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
                          symbolicVariableController,
                          " The variable used, example: x",
                          "symbolic",
                          symbolicControllers,
                          TextInputType.text),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child:
                          inputTitle(context, "The order of differentiation"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(
                          context,
                          symbolicOrderController,
                          "Must be 1 or higher",
                          "symbolic",
                          symbolicControllers,
                          TextInputType.number),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Partial derivative ? ",
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .fontFamily,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .fontSize,
                              color: Provider.of<ThemeManager>(context,
                                              listen: false)
                                          .themeData ==
                                      AppThemeData.lightTheme
                                  ? AppColors.customBlack
                                  : AppColors.customBlackTint80,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Switch(
                            activeColor: AppColors.primaryColor,
                            inactiveThumbColor: Provider.of<ThemeManager>(
                                            context,
                                            listen: false)
                                        .themeData ==
                                    AppThemeData.lightTheme
                                ? AppColors.customBlackTint60
                                : AppColors.customBlackTint90,
                            value: isPartialSymbolic,
                            onChanged: (value) {
                              setState(() {
                                isPartialSymbolic = !isPartialSymbolic;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
        submitButton(context, "symbolic", isSymbolicFieldsReady),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: clearButton(context, symbolicControllers, "symbolic"),
        )
      ],
    );
  }

  Widget symbolicSuccessWidget(
      BuildContext context, String title, String expression, String result) {
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
                    derivativeResult(
                        context, "The derivative result", expression, result),
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
            child: polarResetButton(context, "symbolic"),
          ),
        ],
      ),
    );
  }

  Widget numericSuccessWidget(
      BuildContext context, String title, String expression, String result) {
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
                    derivativeResult(
                        context, "The derivative result", expression, result),
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
            child: polarResetButton(context, "numeric"),
          ),
        ],
      ),
    );
  }

  Widget polarResetButton(BuildContext context, String operation) {
    return GestureDetector(
      onTap: () {
        if (operation == "symbolic") {
          BlocProvider.of<SymbolicDerivativeBloc>(context)
              .add(const SymbolicDerivativeReset());
        } else {
          BlocProvider.of<NumericDerivativeBloc>(context)
              .add(const NumericDerivativeReset());
        }
      },
      child: resetButton(context),
    );
  }

  Column derivativeResult(
      BuildContext context, String title, String expression, String result) {
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
                    context, "result", r"""$$""" + expression + r"""$$"""))),
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: TeXView(
                child: teXViewWidget(
                    context, "result", r"""$$""" + result + r"""$$"""))),
      ],
    );
  }

  Widget textField(
      BuildContext context,
      TextEditingController controller,
      String hint,
      String operation,
      List<TextEditingController> controllers,
      TextInputType inputType) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: textFieldDecoration(context),
      child: TextField(
          onChanged: (value) {
            bool isFiledReady = true;
            for (var controller in controllers) {
              if (controller.text.isEmpty) {
                isFiledReady = false;
                break;
              }
            }
            if (operation == "symbolic") {
              setState(() {
                isSymbolicFieldsReady = isFiledReady;
              });
            } else {
              setState(() {
                isNumericFieldsReady = isFiledReady;
              });
            }
          },
          controller: controller,
          keyboardType: inputType,
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

  Widget clearButton(BuildContext context,
      List<TextEditingController> controllers, String operation) {
    return GestureDetector(
      onTap: () {
        if (operation == "symbolic") {
          setState(() {
            isSymbolicFieldsReady = false;
          });
        } else {
          setState(() {
            isNumericFieldsReady = false;
          });
        }
        for (var element in controllers) {
          element.clear();
        }
      },
      child: clearButtonDecoration(context),
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
                  if (operation == "symbolic") {
                    final request = DerivativeRequest(
                        expression: symbolicExpressionController.text,
                        variable: symbolicVariableController.text,
                        order: int.parse(symbolicOrderController.text),
                        partial: isPartialSymbolic);
                    BlocProvider.of<SymbolicDerivativeBloc>(context)
                        .add(SymbolicDerivativeRequested(request: request));
                  } else {
                    final request = DerivativeRequest(
                        expression: numericExpressionController.text,
                        variable: numericVariableController.text,
                        order: int.parse(numericOrderController.text),
                        derivingPoint: derivingPointController.text,
                        partial: isPartialNumeric);
                    BlocProvider.of<NumericDerivativeBloc>(context)
                        .add(NumericDerivativeRequested(request: request));
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
}
