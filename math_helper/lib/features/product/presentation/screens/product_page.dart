import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/app_bar/tab_bar_item.dart';
import 'package:math_helper/core/ui/components/clear_button_decoration.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/components/text_field_input_decoration.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/product/data/models/product_request.dart';
import 'package:math_helper/features/product/presentation/bloc/numeric_product/numeric_product_bloc.dart';
import 'package:math_helper/features/product/presentation/bloc/symbolic_product/symbolic_product_bloc.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  late TextEditingController symbolicExpressionController;
  late TextEditingController symbolicVariableController;
  late TextEditingController symbolicLowerLimitController;

  late TextEditingController numericExpressionController;
  late TextEditingController numericVariableController;
  late TextEditingController numericLowerLimitController;
  late TextEditingController numericUpperLimitController;

  late List<TextEditingController> symbolicControllers;
  late List<TextEditingController> numericControllers;

  bool isSymbolicFieldsReady = false;
  bool isNumericFieldsReady = false;

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
    symbolicControllers = [
      symbolicExpressionController,
      symbolicVariableController,
      symbolicLowerLimitController
    ];
    numericControllers = [
      numericExpressionController,
      numericVariableController,
      numericLowerLimitController,
      numericUpperLimitController
    ];

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
        Center(child: symbolicScreen(context)),
        Center(child: numericScreen(context))
      ]),
    );
  }

  Widget symbolicScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<SymbolicProductBloc, SymbolicProductState>(
        listener: (context, state) {
          if (state is SymbolicProductFailure) {
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
          if (state is SymbolicProductInitial) {
            return symbolicInitialWidget(context);
          } else if (state is SymbolicProductLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is SymbolicProductSuccess) {
            return successWidget(
                context,
                "Symbolic Product",
                state.response.product,
                state.response.convergent
                    ? state.response.result.toString()
                    : r"\text{This product series is divergent}",
                "symbolic");
          } else if (state is SymbolicProductFailure) {
            return symbolicInitialWidget(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget numericScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<NumericProductBloc, NumericProductState>(
        listener: (context, state) {
          if (state is NumericProductFailure) {
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
          if (state is NumericProductInitial) {
            return numericInitialWidget(context);
          } else if (state is NumericProductLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is NumericProductSuccess) {
            return successWidget(
                context,
                "Numeric Product",
                state.response.product,
                state.response.convergent
                    ? state.response.result.toString()
                    : r"\text{This product series is divergent}",
                "numeric");
          } else if (state is NumericProductFailure) {
            return numericInitialWidget(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget symbolicInitialWidget(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Symbolic Product",
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
                          "Example: 1/(1 + (i^2))",
                          "symbolic",
                          double.infinity),
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
                          " The variable used, example: i",
                          "symbolic",
                          double.infinity),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: inputTitle(context, "The lower limit"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(
                          context,
                          symbolicLowerLimitController,
                          " The lower limit of the product series",
                          "symbolic",
                          double.infinity),
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

  Widget numericInitialWidget(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Numeric Product",
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
                      child: textField(context, numericExpressionController,
                          "Example: 1/(1 + (i^2))", "numeric", double.infinity),
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
                          " The variable used, example: i",
                          "numeric",
                          double.infinity),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: inputTitle(context, "The lower limit"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(
                          context,
                          numericLowerLimitController,
                          "The lower limit of the series",
                          "numeric",
                          double.infinity),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: inputTitle(context, "The upper limit"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(
                          context,
                          numericUpperLimitController,
                          "The upper limit of the series",
                          "numeric",
                          double.infinity),
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
                    productResult(
                        context, "The product result", expression, result),
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
            child: productResetButton(context, operation),
          ),
        ],
      ),
    );
  }

  Column productResult(
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

  Widget productResetButton(BuildContext context, String operation) {
    return GestureDetector(
      onTap: () {
        if (operation == "symbolic") {
          BlocProvider.of<SymbolicProductBloc>(context)
              .add(const SymbolicProductReset());
        } else {
          BlocProvider.of<NumericProductBloc>(context)
              .add(const NumericProductReset());
        }
      },
      child: resetButton(context),
    );
  }

  Widget clearButton(BuildContext context,
      List<TextEditingController> controllers, String operation) {
    return GestureDetector(
      onTap: () {
        for (var element in controllers) {
          element.clear();
        }
        if (operation == "symbolic") {
          setState(() {
            isSymbolicFieldsReady = false;
          });
        } else {
          setState(() {
            isNumericFieldsReady = false;
          });
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
                  if (operation == 'symbolic') {
                    final request = ProductRequest(
                        expression: symbolicExpressionController.text,
                        variable: symbolicVariableController.text,
                        lowerLimit: symbolicLowerLimitController.text == ''
                            ? "0"
                            : symbolicLowerLimitController.text,
                        upperLimit: "n");
                    BlocProvider.of<SymbolicProductBloc>(context).add(
                      SymbolicProductRequested(request: request),
                    );
                  } else {
                    final request = ProductRequest(
                      expression: numericExpressionController.text,
                      variable: numericVariableController.text,
                      lowerLimit: numericLowerLimitController.text,
                      upperLimit: numericUpperLimitController.text,
                    );
                    BlocProvider.of<NumericProductBloc>(context).add(
                      NumericProductRequested(request: request),
                    );
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

  Widget textField(BuildContext context, TextEditingController controller,
      String hint, String operation, double width) {
    return Container(
      height: 50,
      width: width,
      decoration: textFieldDecoration(context),
      child: TextField(
          onChanged: (value) {
            if (operation == "symbolic") {
              if (symbolicExpressionController.text.isNotEmpty &&
                  symbolicVariableController.text.isNotEmpty) {
                setState(() {
                  isSymbolicFieldsReady = true;
                });
              } else {
                setState(() {
                  isSymbolicFieldsReady = false;
                });
              }
            } else {
              if (numericExpressionController.text.isNotEmpty &&
                  numericVariableController.text.isNotEmpty) {
                setState(() {
                  isNumericFieldsReady = true;
                });
              } else {
                setState(() {
                  isNumericFieldsReady = false;
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
  
  loadingComponent(BuildContext context) {}
  
  resetButton(BuildContext context) {}
  
  inputTitle(BuildContext context, String s) {}
}
