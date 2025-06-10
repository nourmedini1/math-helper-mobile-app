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
import 'package:math_helper/features/sum/data/models/sum_request.dart';
import 'package:math_helper/features/sum/presentation/bloc/numeric_sum/numeric_sum_bloc.dart';
import 'package:math_helper/features/sum/presentation/cubit/numeric/numeric_sum_fields/numeric_sum_fields_cubit.dart';
import 'package:math_helper/features/sum/presentation/cubit/numeric/numeric_sum_text/numeric_sum_text_cubit.dart';
import 'package:provider/provider.dart';

class NumericSumInitialScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> boundControllers;
  final TextEditingController variableController;
  const NumericSumInitialScreen(
      {super.key,
      required this.expressionController,
      required this.variableController,
      required this.boundControllers,
      });

  @override
  State<NumericSumInitialScreen> createState() => _NumericSumInitialScreenState();
}

class _NumericSumInitialScreenState extends State<NumericSumInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: "Numeric Sum",
      body: buildBody(),
      submitButton:BlocBuilder<NumericSumFieldsCubit, NumericSumFieldsState>(
                    builder: (context, state) {
                      if (state is NumericSumFieldsReady) {
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
          CustomTextField(
            label: "The expression",
            hint: "The expression to evaluate the sum for",
            controller: widget.expressionController,
            onChanged: (value) => handleInputChange(),
          ),
          CustomTextField(
            label: "The variable",
            hint: "The variable, default is n",
            controller: widget.variableController,
            onChanged: (value) => () {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:  EdgeInsets.only(left: 32, bottom: 5),
                  child: TextFieldLabel(label: "The sum bounds"),
                ),
                BlocBuilder<NumericSumTextCubit, NumericSumTextState>(
                  builder: (context, state) {
                    if (state is NumericSumTextInitial) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomPopupInvoker(
                          onTap: () => limitsPopup(context),
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
          
      
          
        ],
      ),
    );
  }

  
  
  void limitsPopup(BuildContext context) {
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Numeric Sum",
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
                  hint: "The lower bound of the sum",
                  controller: widget.boundControllers[0],
                  onChanged: (value) => handlePopupInputChange(),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "The upper bound of the sum",
                  controller: widget.boundControllers[1],
                  onChanged: (value) => handlePopupInputChange(),
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

void handlePopupInputChange() {
 context.read<NumericSumTextCubit>().updateLowerLimit(
          widget.boundControllers[0].text.isEmpty ? "0" : widget.boundControllers[0].text,
        );
  
     context.read<NumericSumTextCubit>().updateUpperLimit(
          widget.boundControllers[1].text.isEmpty ? "oo" : widget.boundControllers[1].text,
        );
}
 

  void handleClearButtonPressed() {
    for (var controller in widget.boundControllers) {
      controller.clear();
    }
    widget.expressionController.clear();
    widget.variableController.clear();
   
    context.read<NumericSumTextCubit>().reset();   
    context.read<NumericSumFieldsCubit>().reset();
  }

  

  

 void handleInputChange() {
  context.read<NumericSumFieldsCubit>().checkAllFieldsReady(
    widget.expressionController.text.isNotEmpty
      );
}



  void handleSubmitButtonPressed() {
   final SumRequest request = SumRequest(
      expression: widget.expressionController.text,
      variable: widget.variableController.text.isEmpty ? "n" : widget.variableController.text,
      lowerLimit: widget.boundControllers[0].text.isEmpty ? "0" : widget.boundControllers[0].text,
      upperLimit: widget.boundControllers[1].text.isEmpty ? "oo" : widget.boundControllers[1].text,
    );
    context.read<NumericSumBloc>().add(NumericSumRequested(request: request));
  }


    
    
  
}

