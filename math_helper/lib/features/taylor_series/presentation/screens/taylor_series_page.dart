import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/clear_button_decoration.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/components/text_field_input_decoration.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/taylor_series/data/models/taylor_series_request.dart';
import 'package:math_helper/features/taylor_series/presentation/bloc/expand_taylor_series/expand_taylor_series_bloc.dart';
import 'package:provider/provider.dart';

class TaylorSeriesPage extends StatefulWidget {
  const TaylorSeriesPage({super.key});

  @override
  State<TaylorSeriesPage> createState() => _TaylorSeriesPageState();
}

class _TaylorSeriesPageState extends State<TaylorSeriesPage> {
  late TextEditingController expressionController;
  late TextEditingController variableController;
  late TextEditingController orderController;
  late TextEditingController nearController;
  late List<TextEditingController> controllers;
  bool isFieldsReady = false;
  @override
  void initState() {
    super.initState();
    expressionController = TextEditingController();
    variableController = TextEditingController();
    orderController = TextEditingController();
    nearController = TextEditingController();
    controllers = [
      expressionController,
      variableController,
      orderController,
      nearController
    ];
  }

  @override
  void dispose() {
    expressionController.dispose();
    variableController.dispose();
    orderController.dispose();
    nearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          context: context,
          tabController: null,
          hasTabBar: false,
          appBarBottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Divider(
              height: 1,
              color: Provider.of<ThemeManager>(context).themeData ==
                      AppThemeData.lightTheme
                  ? AppColors.primaryColorTint50
                  : AppColors.customBlackTint60,
            ),
          ),
          hasHomeIcon: true),
      drawer: const CustomDrawer(),
      body: Center(child: taylorSeriesScreen(context)),
    );
  }

  Widget clearButton(
      BuildContext context, List<TextEditingController> controllers) {
    return GestureDetector(
      onTap: () {
        for (var element in controllers) {
          element.clear();
        }
      },
      child: clearButtonDecoration(context),
    );
  }

  Widget taylorSeriesResetButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ExpandTaylorSeriesBloc>(context)
            .add(const ExpandTaylorSeriesReset());
      },
      child: resetButton(context),
    );
  }

  Column taylorSeriesResult(
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

  Widget taylorSeriesScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<ExpandTaylorSeriesBloc, ExpandTaylorSeriesState>(
        listener: (context, state) {
          if (state is ExpandTaylorSeriesFailure) {
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
          if (state is ExpandTaylorSeriesInitial) {
            return taylorSeriesInitial(context);
          } else if (state is ExpandTaylorSeriesLoading) {
            return Center(
              child: loadingComponent(context),
            );
          } else if (state is ExpandTaylorSeriesSuccess) {
            return successWidget(
              context,
              "Taylor Series",
              state.response.expression,
              state.response.result.toString(),
            );
          } else if (state is ExpandTaylorSeriesFailure) {
            return taylorSeriesInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget taylorSeriesInitial(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Taylor Series",
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
                          expressionController,
                          "Example: cos(x)/(1 + sin(x))",
                          controllers,
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
                          variableController,
                          " The variable used, example: x",
                          controllers,
                          TextInputType.text),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: inputTitle(context, "The order of expansion"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(
                          context,
                          orderController,
                          "Must be 1 or higher",
                          controllers,
                          TextInputType.number),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: inputTitle(context, "Expansion target"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: textField(
                          context,
                          nearController,
                          "expand the expression near...",
                          controllers,
                          TextInputType.text),
                    ),
                  ],
                )),
          ),
        ),
        submitButton(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: clearButton(
            context,
            controllers,
          ),
        )
      ],
    );
  }

  Widget successWidget(
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
                    taylorSeriesResult(
                        context, "The expansion result", expression, result),
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
            child: taylorSeriesResetButton(context),
          ),
        ],
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Center(
            child: GestureDetector(
          onTap: isFieldsReady
              ? () {
                  TaylorSeriesRequest request = TaylorSeriesRequest(
                    expression: expressionController.text,
                    variable: variableController.text,
                    order: int.parse(orderController.text == ''
                        ? "1"
                        : orderController.text),
                    near: nearController.text == '' ? "0" : nearController.text,
                  );
                  BlocProvider.of<ExpandTaylorSeriesBloc>(context)
                      .add(ExpandTaylorSeriesRequested(request: request));
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

  Widget textField(
      BuildContext context,
      TextEditingController controller,
      String hint,
      List<TextEditingController> controllers,
      TextInputType inputType) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: textFieldDecoration(context),
      child: TextField(
          onChanged: (value) {
            if (expressionController.text.isNotEmpty &&
                variableController.text.isNotEmpty) {
              setState(() {
                isFieldsReady = true;
              });
            } else {
              setState(() {
                isFieldsReady = false;
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
}
