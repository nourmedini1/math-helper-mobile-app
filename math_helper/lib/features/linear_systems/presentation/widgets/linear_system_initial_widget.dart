// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/clear_button.dart';
import 'package:math_helper/core/ui/components/custom_text_field.dart';
import 'package:math_helper/core/ui/components/input_container.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/linear_systems/data/models/linear_system_request.dart';
import 'package:math_helper/features/linear_systems/presentation/bloc/solve_linear_system/solve_linear_system_bloc.dart';
import 'package:math_helper/features/linear_systems/presentation/cubit/linear_system_equations/linear_system_equations_cubit.dart';
import 'package:math_helper/features/linear_systems/presentation/cubit/linear_system_equations_fields/linear_system_equations_fields_cubit.dart';
import 'package:provider/provider.dart';

class LinearSystemInitialWidget extends StatefulWidget {
  final TextEditingController nbEquationsController;
  final TextEditingController variablesController;
  final List<TextEditingController> equationsControllers;
  final List<TextEditingController> rightHandSideControllers;
  const LinearSystemInitialWidget(
      {super.key,
      required this.nbEquationsController,
      required this.variablesController,
      required this.equationsControllers,
      required this.rightHandSideControllers,
      });

  @override
  State<LinearSystemInitialWidget> createState() => _LinearSystemIitialScreenState();
}

class _LinearSystemIitialScreenState extends State<LinearSystemInitialWidget> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: "Linear System of Equations",
      body: buildBody(),
      submitButton: BlocBuilder<LinearSystemEquationsFieldsCubit, LinearSystemEquationsFieldsState>(
                    builder: (context, state) {
                      if (state is LinearSystemEquationsFieldsReady) {
                        return SubmitButton(
                          color: Provider.of<ThemeManager>(context).themeData ==
                                  AppThemeData.lightTheme
                              ? AppColors.primaryColorTint50
                              : AppColors.primaryColor,
                          onPressed: () => handleSubmitButtonPressed(),
                        );
                      } else {
                        return SubmitButton(
                          color: AppColors.customBlackTint80,
                          onPressed: () {}, // Disable button if not ready
                        );
                      }
                    },
                  ),
      clearButton: ClearButton(
        onPressed: () => handleClearButtonPressed(),
      ),
    );
  }

  

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 10),
            child: TextFieldLabel(label: "The linear system"),
          ),
          CustomTextField(
            keyboardType: TextInputType.number,
            hint: "The number of equations, default is 3",
            controller: widget.nbEquationsController,
            onChanged: (value) => () {},
          ),
          CustomTextField(
            hint: "The variables used, default is x,y,z",
            controller: widget.variablesController,
            onChanged: (value) => () {},
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 64, vertical: 10),
            child: BlocBuilder<LinearSystemEquationsCubit, LinearSystemEquationsState>(
                builder: (context, state) {
                  if (state is LinearSystemEquationsInitial) {
                    return SubmitButton(
                      color : Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
                          ? AppColors.primaryColorTint50
                          : AppColors.primaryColor,
                      text: "Generate Equations",
                      icon: Icons.add,
                      onPressed: () {
                        int nbEquations = int.tryParse(widget.nbEquationsController.text) ?? 3;
                        List<String> variables = widget.variablesController.text.isNotEmpty
                            ? widget.variablesController.text.split(',')
                            : ['x', 'y', 'z'];
                        widget.equationsControllers.clear();
                        widget.rightHandSideControllers.clear();
                        for (int i = 0; i < nbEquations; i++) {
                          widget.equationsControllers.add(TextEditingController());
                          widget.rightHandSideControllers.add(TextEditingController());
                        }
                        _showPopup(
                          context,
                          title: "Linear System",
                          label: "The system of equations",
                          equationControllers: widget.equationsControllers,
                          rightHandSideControllers: widget.rightHandSideControllers,
                          nbEquations: nbEquations,
                          variables: variables,
                          onClear: () {
                            for (var controller in widget.equationsControllers) {
                              controller.clear();
                            }
                            for (var controller in widget.rightHandSideControllers) {
                              controller.clear();
                            }
                            context.read<LinearSystemEquationsFieldsCubit>().reset();
                            context.read<LinearSystemEquationsCubit>().reset();
                          },
            
                        );
                      },
                    );
                  } else if (state is LinearSystemEquationsGenerated) {
                    return SubmitButton(
                      color: AppColors.secondaryColor,
                      text: "Check Equations",
                      icon: Icons.search,
                      onPressed: () {
                        _showPopup(
                          context,
                          title: "Linear System",
                          label: "The system of equations",
                          equationControllers: widget.equationsControllers,
                          rightHandSideControllers: widget.rightHandSideControllers,
                          nbEquations: state.nbEquations,
                          variables: state.variables,
                          onClear: () {
                            for (var controller in widget.equationsControllers) {
                              controller.clear();
                            }
                            for (var controller in widget.rightHandSideControllers) {
                              controller.clear();
                            }
                            context.read<LinearSystemEquationsFieldsCubit>().reset();
                            context.read<LinearSystemEquationsCubit>().reset();
                          },
                        );
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
          ),
             
        ],
      ),
    );
  }


  void _showPopup(
    BuildContext context, {
    required String title,
    required String label,
    required List<TextEditingController> equationControllers,
    required List<TextEditingController> rightHandSideControllers,
    required int nbEquations,
    required List<String> variables,
    required VoidCallback onClear,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    "Linear Equations",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
                          ? AppColors.primaryColorTint50
                          : AppColors.primaryColor,
                      fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(nbEquations, (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 16,
                            child: CustomTextField(
                              hint: "Example: 2x + 3y", 
                              controller: equationControllers[i], 
                              onChanged: (value) {
                                bool allFieldsFilled = equationControllers.every((controller) => controller.text.isNotEmpty) &&
                                    rightHandSideControllers.every((controller) => controller.text.isNotEmpty);
                                bool anyFieldFilled = equationControllers.any((controller) => controller.text.isNotEmpty) ||
                                    rightHandSideControllers.any((controller) => controller.text.isNotEmpty);
                                context.read<LinearSystemEquationsFieldsCubit>().checkAllFieldsFilled(allFieldsFilled);
                                context.read<LinearSystemEquationsCubit>().checkStatus(anyFieldFilled,nbEquations, variables);
                              },
                            ),
                          ),
                           Expanded(
                            flex: 0,
                             child: Text(
                              "=",
                              style: TextStyle(
                                fontSize: 20,
                                color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
                                    ? AppColors.customBlack
                                    : AppColors.customBlackTint90,
                                fontWeight: FontWeight.bold,
                              ),
                                                       ),
                           ),
              
                          Expanded(
                            flex: 7,
                            child: CustomTextField(
                              hint: "",
                              controller: rightHandSideControllers[i],
                              onChanged: (value) {
                                bool allFieldsFilled = equationControllers.every((controller) => controller.text.isNotEmpty) &&
                                    rightHandSideControllers.every((controller) => controller.text.isNotEmpty);
                                bool anyFieldFilled = equationControllers.any((controller) => controller.text.isNotEmpty) ||
                                    rightHandSideControllers.any((controller) => controller.text.isNotEmpty);
                                context.read<LinearSystemEquationsFieldsCubit>().checkAllFieldsFilled(allFieldsFilled);
                                context.read<LinearSystemEquationsCubit>().checkStatus(anyFieldFilled,nbEquations, variables);
                              },
                            )
                          ),
              
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: SubmitButton(
                      color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
                          ? AppColors.primaryColorTint50
                          : AppColors.primaryColor,
                      text: "Confirm",
                      icon: Icons.check,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: ClearButton(
                      color: AppColors.secondaryColor,
                      text: "Clear All",
                      onPressed: onClear,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  
  
 



  void handleClearButtonPressed() {
    widget.equationsControllers.clear();
    widget.rightHandSideControllers.clear();
    widget.nbEquationsController.clear();
    widget.variablesController.clear();
    context.read<LinearSystemEquationsFieldsCubit>().reset();
    context.read<LinearSystemEquationsCubit>().reset(); 
  }

  

  

 



  void handleSubmitButtonPressed() {
    List<String> variables = widget.variablesController.text.isNotEmpty
        ? widget.variablesController.text.split(',')
        : ['x', 'y', 'z'];

    List<String> equations = widget.equationsControllers.map((controller) => controller.text).toList();
    List<String> rightHandSides = widget.rightHandSideControllers.map((controller) => controller.text).toList();

    LinearSystemRequest request = LinearSystemRequest(
      equations: equations, 
      variables: variables, 
      rightHandSide: rightHandSides);

    context.read<SolveLinearSystemBloc>().add(SolveLinearSystemRequested(request: request));
    
  }
}

