import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/clear_button_decoration.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/components/tex_view_widget.dart';
import 'package:math_helper/core/ui/components/text_field_decoration.dart';
import 'package:math_helper/core/ui/components/text_field_input_decoration.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/data/models/polar_form_request.dart';
import 'package:math_helper/features/complex/presentation/bloc/polar_form/polar_form_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tex/flutter_tex.dart';

class ComplexPolarFormPage extends StatefulWidget {
  const ComplexPolarFormPage({super.key});

  @override
  State<ComplexPolarFormPage> createState() => _ComplexPolarFormPageState();
}

class _ComplexPolarFormPageState extends State<ComplexPolarFormPage> {
  late TextEditingController realController;
  late TextEditingController imaginaryController;
  bool isFieldsReady = false;

  @override
  void initState() {
    super.initState();
    realController = TextEditingController();
    imaginaryController = TextEditingController();
  }

  @override
  void dispose() {
    realController.dispose();
    imaginaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
        body: Center(
          child: BlocConsumer<PolarFormBloc, PolarFormState>(
            listener: (context, state) {
              if (state is PolarFormFailure) {
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
              if (state is PolarFormInitial) {
                return initialComponent(
                    context, realController, imaginaryController);
              } else if (state is PolarFormLoading) {
                return loadingComponent(context);
              } else if (state is PolarFormOperationSuccess) {
                return successComponent(context, state.response.algebraicForm,
                    state.response.polarForm);
              } else {
                return initialComponent(
                    context, realController, imaginaryController);
              }
            },
          ),
        ));
  }

  Widget successComponent(
      BuildContext context, String algebraicForm, String polarForm) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                "Polar Form",
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
                    complexResult(context, "converted complex number",
                        algebraicForm, polarForm),
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
            child: polarResetButton(context),
          ),
        ],
      ),
    );
  }

  Widget initialComponent(BuildContext context,
      TextEditingController controller1, TextEditingController controller2) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                "Polar Form",
                style: TextStyle(
                    color: AppColors.primaryColorTint50,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    fontFamily:
                        Theme.of(context).textTheme.titleMedium!.fontFamily),
              )),
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
                        child: Text(
                          "The complex number",
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .fontFamily,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .fontSize,
                            color:
                                Provider.of<ThemeManager>(context).themeData ==
                                        AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customBlackTint80,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: textField(
                            context, controller1, "Enter the real component"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: textField(context, controller2,
                            "Enter the imaginary component"),
                      ),
                    ],
                  ),
                )),
          ),
          submitButton(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: polarClearButton(context),
          )
        ],
      ),
    );
  }

  Widget loadingComponent(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: Provider.of<ThemeManager>(context, listen: false).themeData ==
                AppThemeData.lightTheme
            ? AppColors.primaryColor
            : AppColors.customBlackTint60,
      ),
    );
  }

  Widget polarClearButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        realController.clear();
        imaginaryController.clear();
      },
      child: clearButtonDecoration(context),
    );
  }

  Widget polarResetButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PolarFormBloc>(context).add(const PolarFormReset());
      },
      child: resetButton(context),
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

  Widget submitButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Center(
            child: GestureDetector(
          onTap: isFieldsReady
              ? () {
                  final PolarFormRequest request = PolarFormRequest(
                    real: parseNumber(realController.text),
                    imaginary: parseNumber(imaginaryController.text),
                  );

                  BlocProvider.of<PolarFormBloc>(context).add(
                    PolarFormRequested(request: request),
                  );
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

  dynamic parseNumber(dynamic number) {
    try {
      int parsedInt = int.parse(number.toString());
      return parsedInt;
    } on FormatException {
      return double.parse(number.toString());
    }
  }

  Widget textField(
      BuildContext context, TextEditingController controller, String hint) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: textFieldDecoration(context),
      child: TextField(
          onChanged: (value) {
            if (realController.text.isNotEmpty &&
                imaginaryController.text.isNotEmpty) {
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
