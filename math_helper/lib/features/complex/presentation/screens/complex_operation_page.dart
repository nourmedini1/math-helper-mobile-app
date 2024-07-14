import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/clear_button_decoration.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/components/text_field_input_decoration.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_request.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_addition/complex_addition_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_multiplication/complex_multiplication_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_substraction/complex_substraction_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tex/flutter_tex.dart';

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
  bool isAdditionFieldsReady = false;
  bool isSubstractionFieldsReady = false;
  bool isMultiplicationFieldsReady = false;

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
              child: complexAdditionScreen(context, [
            additionFirstRealController,
            additionSecondRealController,
            additionFirstImaginaryController,
            additionSecondImaginaryController
          ])),
          Center(
              child: complexSubstractionScreen(context, [
            substractionFirstRealController,
            substractionSecondRealController,
            substractionFirstImaginaryController,
            substractionSecondImaginaryController
          ])),
          Center(
              child: complexMultiplicationScreen(context, [
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
            color: Provider.of<ThemeManager>(context).themeData ==
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
                      Provider.of<ThemeManager>(context).themeData ==
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

  Widget complexAdditionScreen(
      BuildContext context, List<TextEditingController> controllers) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<ComplexAdditionBloc, ComplexAdditionState>(
        listener: (context, state) {
          if (state is ComplexAdditionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.customRed,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ComplexAdditionInitial) {
            return inputWidget(
              context,
              "Complex Addition",
              controllers,
            );
          } else if (state is ComplexAdditionLoading) {
            return Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Provider.of<ThemeManager>(context, listen: false)
                            .themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.primaryColor
                    : AppColors.customBlackTint60,
              ),
            );
          } else if (state is ComplexAdditionSuccess) {
            return complexSuccessScreen(context, state, "Complex Addition");
          } else if (state is ComplexAdditionFailure) {
            return inputWidget(
              context,
              "Complex Addition",
              controllers,
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget complexSubstractionScreen(
      BuildContext context, List<TextEditingController> controllers) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<ComplexSubstractionBloc, ComplexSubstractionState>(
        listener: (context, state) {
          if (state is ComplexSubstractionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.customRed,
              ),
            );
          } else if (state is ComplexSubstractionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Operation completed successfully"),
                backgroundColor: Color.fromARGB(255, 160, 223, 186),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ComplexSubstractionInitial) {
            return inputWidget(
              context,
              "Complex Substraction",
              controllers,
            );
          } else if (state is ComplexSubstractionLoading) {
            return Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Provider.of<ThemeManager>(context, listen: false)
                            .themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.primaryColor
                    : AppColors.customBlackTint60,
              ),
            );
          } else if (state is ComplexSubstractionSuccess) {
            return complexSuccessScreen(context, state, "Complex Substraction");
          } else if (state is ComplexSubstractionFailure) {
            return inputWidget(
              context,
              "Complex Substraction",
              controllers,
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget complexMultiplicationScreen(
      BuildContext context, List<TextEditingController> controllers) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child:
          BlocConsumer<ComplexMultiplicationBloc, ComplexMultiplicationState>(
        listener: (context, state) {
          if (state is ComplexMultiplicationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.customRed,
              ),
            );
          } else if (state is ComplexMultiplicationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Operation completed successfully"),
                backgroundColor: Color.fromARGB(255, 160, 223, 186),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ComplexMultiplicationInitial) {
            return inputWidget(
              context,
              "Complex Multiplication",
              controllers,
            );
          } else if (state is ComplexMultiplicationLoading) {
            return Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Provider.of<ThemeManager>(context, listen: false)
                            .themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.primaryColor
                    : AppColors.customBlackTint60,
              ),
            );
          } else if (state is ComplexMultiplicationSuccess) {
            return complexSuccessScreen(
                context, state, "Complex Multiplication");
          } else if (state is ComplexMultiplicationFailure) {
            return inputWidget(
              context,
              "Complex Multiplication",
              controllers,
            );
          }
          return Container();
        },
      ),
    );
  }

  Column complexSuccessScreen(
      BuildContext context, dynamic state, String operation) {
    return Column(
      children: [
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
                  complexResult(context, "First complex number",
                      state.response.z1, state.response.polarZ1),
                  complexResult(context, "Second complex number",
                      state.response.z2, state.response.polarZ2),
                  complexResult(
                      context,
                      "The result",
                      state.response.algebraicResult,
                      state.response.polarResult),
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
          child: complexResetButton(operation),
        ),
      ],
    );
  }

  Column complexResult(BuildContext context, String title, String algebraicForm,
      String polarForm) {
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
                    context, "result", r"""$$""" + algebraicForm + r"""$$"""))),
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: TeXView(
                child: teXViewWidget(
                    context, "result", r"""$$""" + polarForm + r"""$$"""))),
      ],
    );
  }

  Column inputWidget(BuildContext context, String title,
      List<TextEditingController> controllers) {
    return Column(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFields(
                    context,
                    "First complex number",
                    "Enter the real component",
                    "Enter the imaginary component",
                    title,
                    controllers,
                    controllers[0],
                    controllers[1]),
                textFields(
                    context,
                    "Second complex number",
                    "Enter the real component",
                    "Enter the imaginary component",
                    title,
                    controllers,
                    controllers[2],
                    controllers[3]),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: complexSubmitButton(
              context,
              title,
              title == 'Complex Addition'
                  ? isAdditionFieldsReady
                  : title == 'Complex Substraction'
                      ? isSubstractionFieldsReady
                      : isMultiplicationFieldsReady,
              controllers),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: complexClearButton(title),
        )
      ],
    );
  }

  Padding complexSubmitButton(BuildContext context, String operation,
      bool isFieldsReady, List<TextEditingController> controllers) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
        child: Center(
            child: GestureDetector(
          onTap: isFieldsReady
              ? () {
                  final ComplexOperationsRequest request =
                      ComplexOperationsRequest(
                          real1: parseNumber(controllers[0].text),
                          imaginary1: parseNumber(controllers[2].text),
                          real2: parseNumber(controllers[1].text),
                          imaginary2: parseNumber(controllers[2].text));
                  switch (operation) {
                    case "Complex Addition":
                      BlocProvider.of<ComplexAdditionBloc>(context).add(
                        ComplexAdditionRequested(request: request),
                      );
                      break;

                    case "Complex Substraction":
                      BlocProvider.of<ComplexSubstractionBloc>(context).add(
                        ComplexSubstractionRequested(request: request),
                      );
                      break;
                    case "Complex Multiplication":
                      BlocProvider.of<ComplexMultiplicationBloc>(context).add(
                        ComplexMultiplicationRequested(request: request),
                      );
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

  GestureDetector complexResetButton(String operation) {
    return GestureDetector(
        onTap: () {
          switch (operation) {
            case "Complex Addition":
              BlocProvider.of<ComplexAdditionBloc>(context).add(
                const ComplexAdditionReset(),
              );
              break;

            case "Complex Substraction":
              BlocProvider.of<ComplexSubstractionBloc>(context).add(
                const ComplexSubstractionReset(),
              );
              break;
            case "Complex Multiplication":
              BlocProvider.of<ComplexMultiplicationBloc>(context).add(
                const ComplexMultiplicationReset(),
              );
              break;
          }
        },
        child: resetButton(context));
  }

  GestureDetector complexClearButton(String operation) {
    return GestureDetector(
        onTap: () {
          switch (operation) {
            case "Complex Addition":
              additionFirstImaginaryController.clear();
              additionFirstRealController.clear();
              additionSecondImaginaryController.clear();
              additionSecondRealController.clear();
              break;

            case "Complex Substraction":
              substractionFirstImaginaryController.clear();
              substractionFirstRealController.clear();
              substractionSecondImaginaryController.clear();
              substractionSecondRealController.clear();
              break;
            case "Complex Multiplication":
              multiplicationFirstImaginaryController.clear();
              multiplicationFirstRealController.clear();
              multiplicationSecondImaginaryController.clear();
              multiplicationSecondRealController.clear();
              break;
          }
        },
        child: clearButtonDecoration(context));
  }

  Padding textFields(
      BuildContext context,
      String label,
      String hint,
      String hint2,
      String operation,
      List<TextEditingController> controllers,
      TextEditingController controller1,
      TextEditingController controller2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
                fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                color: Provider.of<ThemeManager>(context).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customBlackTint80,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          textField(context, hint, operation, controller1, controllers),
          const SizedBox(
            height: 10,
          ),
          textField(context, hint2, operation, controller2, controllers)
        ],
      ),
    );
  }

  Padding textField(
      BuildContext context,
      String hint,
      String operation,
      TextEditingController controller,
      List<TextEditingController> controllers) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 50,
        decoration: textFieldDecoration(context),
        child: TextField(
            onChanged: (value) {
              if (controllers[0].text.isNotEmpty &&
                  controllers[1].text.isNotEmpty &&
                  controllers[2].text.isNotEmpty &&
                  controllers[3].text.isNotEmpty) {
                switch (operation) {
                  case "Complex Addition":
                    setState(() {
                      isAdditionFieldsReady = true;
                    });

                    break;
                  case "Complex Substraction":
                    setState(() {
                      isSubstractionFieldsReady = true;
                    });
                    break;
                  case "Complex Multiplication":
                    setState(() {
                      isMultiplicationFieldsReady = true;
                    });
                    break;
                }
              } else {
                switch (operation) {
                  case "Complex Addition":
                    setState(() {
                      isAdditionFieldsReady = false;
                    });
                    break;
                  case "Complex Substraction":
                    setState(() {
                      isSubstractionFieldsReady = false;
                    });
                    break;
                  case "Complex Multiplication":
                    setState(() {
                      isMultiplicationFieldsReady = false;
                    });
                    break;
                }
              }
            },
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            cursorColor:
                Provider.of<ThemeManager>(context, listen: false).themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.primaryColor
                    : AppColors.customWhite,
            cursorWidth: 0.8,
            style: TextStyle(
                color: Provider.of<ThemeManager>(context, listen: false)
                            .themeData ==
                        AppThemeData.lightTheme
                    ? AppColors.customBlack
                    : AppColors.customWhite,
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily),
            textAlign: TextAlign.start,
            controller: controller,
            decoration: textFieldInputDecoration(context, hint)),
      ),
    );
  }

  dynamic parseNumber(dynamic number) {
    try {
      int parsedInt = int.parse(number.toString());
      return parsedInt;
    } on FormatException {
      return double.parse(number.toString());
    }
  }
}
