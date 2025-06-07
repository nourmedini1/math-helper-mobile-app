// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/clear_button.dart';
import 'package:math_helper/core/ui/components/custom_popup_invoker.dart';
import 'package:math_helper/core/ui/components/custom_text_field.dart';
import 'package:math_helper/core/ui/components/input_container.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_request.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/second_order_differential_equation/second_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/second_order_coefficients/second_order_coefficients_cubit.dart';
import 'package:math_helper/features/differential_equations/presentation/cubit/second_order_constraints/second_order_constraints_cubit.dart';
import 'package:provider/provider.dart';

class SecondOrderOdeInitialScreen extends StatefulWidget {
  final List<TextEditingController> coefficientControllers;
  final List<TextEditingController> initialConditionControllers;
  final TextEditingController constantController;
  final TextEditingController RHSController;
  const SecondOrderOdeInitialScreen(
      {super.key,
      required this.coefficientControllers,
      required this.initialConditionControllers,
      required this.constantController,
      required this.RHSController});

  @override
  State<SecondOrderOdeInitialScreen> createState() => _SecondOrderOdeInitialScreenState();
}

class _SecondOrderOdeInitialScreenState extends State<SecondOrderOdeInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: "Second Order ODE",
      body: buildBody(),
      submitButton: SubmitButton(
        color: Provider.of<ThemeManager>(context).themeData ==
                AppThemeData.lightTheme
            ? AppColors.primaryColorTint50
            : AppColors.primaryColor,
        onPressed: () => handleSubmitButtonPressed(),
      ),
      clearButton: ClearButton(
        onPressed: () => handleClearButtonPressed(),
      ),
    );
  }

  

  

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:  EdgeInsets.only(left: 32, bottom: 5),
                  child: TextFieldLabel(label: "The coefficients"),
                ),
                BlocBuilder<SecondOrderCoefficientsCubit, SecondOrderCoefficientsState>(
            builder: (context, state) {
              if (state is SecondOrderCoefficientsInitial) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomPopupInvoker(
                    onTap: () => secondOrderCoefficientsPopup(context),
                    text: state.text,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 32, bottom: 5),
                  child: TextFieldLabel(label: "The initial conditions"),
                ),
                BlocBuilder<SecondOrderConstraintsCubit, SecondOrderConstraintsState>(
                  builder: (context, state) {
                    if (state is SecondOrderConstraintsInitial) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomPopupInvoker(
                          onTap: () => secondOrderInitialConditionsPopup(context),
                          text: state.text,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
          CustomTextField(
            label: "The constant",
            hint: "Enter the constant, default is 0",
            controller: widget.constantController,
            onChanged: (value) => () {},
          ),
          CustomTextField(
            label: "The right hand side",
            hint: "the right hand side of the equation",
            controller: widget.RHSController,
            onChanged: (value) => () {},
          ),
        ],
      ),
    );
  }

  
  void secondOrderCoefficientsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Second Order ODE",
                      style: TextStyle(
                        color:
                            Provider.of<ThemeManager>(context, listen: false)
                                    .themeData ==
                                AppThemeData.lightTheme
                                ? AppColors.primaryColorTint50
                                : AppColors.primaryColor,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontFamily:
                            Theme.of(context).textTheme.titleMedium!.fontFamily,
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  hint: "Input the first coefficient",
                  controller: widget.coefficientControllers[0],
                  onChanged: (value) => handleInputChange(),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "Input the second coefficient",
                  controller: widget.coefficientControllers[1],
                  onChanged: (value) => handleInputChange(),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "Input the third coefficient",
                  controller: widget.coefficientControllers[2],
                  onChanged: (value) => handleInputChange(),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                  child: SubmitButton(
                    text: "Confirm",
                    icon: Icons.check,
                    color:
                        Provider.of<ThemeManager>(context).themeData ==
                                AppThemeData.lightTheme
                            ? AppColors.primaryColorTint50
                            : AppColors.primaryColor,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void secondOrderInitialConditionsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Second Order ODE",
                      style: TextStyle(
                        color:
                            Provider.of<ThemeManager>(context, listen: false)
                                    .themeData ==
                                AppThemeData.lightTheme
                                ? AppColors.primaryColorTint50
                                : AppColors.primaryColor,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontFamily:
                            Theme.of(context).textTheme.titleMedium!.fontFamily,
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  hint: "example: x,f(x)",
                  controller: widget.initialConditionControllers[0],
                  onChanged: (value) => handleInputChange(),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "example: x,f'(x)",
                  controller: widget.initialConditionControllers[1],
                  onChanged: (value) => handleInputChange(),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "example: x,f''(x)",
                  controller: widget.initialConditionControllers[2],
                  onChanged: (value) => handleInputChange(),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                  child: SubmitButton(
                    text: "Confirm",
                    icon: Icons.check,
                    color:
                        Provider.of<ThemeManager>(context).themeData ==
                                AppThemeData.lightTheme
                            ? AppColors.primaryColorTint50
                            : AppColors.primaryColor,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
 

  void handleClearButtonPressed() {
    for (var controller in widget.coefficientControllers) {
      controller.clear();
    }
    for (var controller in widget.initialConditionControllers) {
      controller.clear();
    }
    widget.constantController.clear();
    widget.RHSController.clear();
    context.read<SecondOrderCoefficientsCubit>().resetText();
    context.read<SecondOrderConstraintsCubit>().resetText();
    
  }

  
 
 void handleInputChange() {
  List<String> coefficients = widget.coefficientControllers
      .map((controller) => controller.text)
      .toList();
  List<String> initialConditions = widget.initialConditionControllers
      .map((controller) => controller.text)
      .toList();

  context.read<SecondOrderCoefficientsCubit>().updateFirstCoefficients(
    coefficients[0]);
  context.read<SecondOrderCoefficientsCubit>().updateSecondCoefficients(
    coefficients[1]);
  context.read<SecondOrderCoefficientsCubit>().updateThirdCoefficients(
      coefficients[2]);

  context.read<SecondOrderConstraintsCubit>().updateFirstConstraints(
      _validateAndSplit(initialConditions[0]));
  context.read<SecondOrderConstraintsCubit>().updateSecondConstraints(
      _validateAndSplit(initialConditions[1]));
  context.read<SecondOrderConstraintsCubit>().updateThirdConstraints(
      _validateAndSplit(initialConditions[2]));
}

List<String> _validateAndSplit(String input) {
  // Matches "something,something" where both sides are non-empty and no extra commas
  final pattern = RegExp(r'^[^,]+,[^,]+$');
  if (pattern.hasMatch(input.trim())) {
    return input.split(',');
  } else {
    return ['0', '0'];
  }
}
 

  void handleSubmitButtonPressed() {
    DifferentialEquationRequest request = parseRequest(
      widget.constantController.text,
      widget.RHSController.text,
      widget.coefficientControllers,
      widget.initialConditionControllers,
    );
    BlocProvider.of<SecondOrderDifferentialEquationBloc>(context)
        .add(SecondOrderDifferentialEquationRequested(request: request));
     
  }

  DifferentialEquationRequest parseRequest(
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
        variable: "x",
        coefficients: coefficients,
        initialConditions: initialConditions,
        constant: constant,
        rightHandSide: rightHandSide);
  }
}
