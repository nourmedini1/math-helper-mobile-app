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
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_integral/single_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/cubit/definite_integral/single_fields/single_fields_cubit.dart';
import 'package:math_helper/features/integrals/presentation/cubit/definite_integral/single_limits_text/single_definite_integral_limits_text_cubit.dart';
import 'package:provider/provider.dart';

class SingleDefiniteIntegralInitialScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> limitsControllers;
  final TextEditingController variableController;
  const SingleDefiniteIntegralInitialScreen(
      {super.key,
      required this.expressionController,
      required this.limitsControllers,
      required this.variableController,
      });

  @override
  State<SingleDefiniteIntegralInitialScreen> createState() => _SingleDefiniteIntegralInitialScreenState();
}

class _SingleDefiniteIntegralInitialScreenState extends State<SingleDefiniteIntegralInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: "Single Integral",
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: "The expression",
            hint: "The expression to integrate",
            controller: widget.expressionController,
            onChanged: (value) => handleInputChange(),
          ),
          CustomTextField(
            label: "The variable",
            hint: "The variable of integration, default is x",
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
                  child: TextFieldLabel(label: "The limits"),
                ),
                BlocBuilder<SingleDefiniteIntegralLimitsTextCubit, SingleDefiniteIntegralLimitsTextState>(
                  builder: (context, state) {
                    if (state is SingleDefiniteIntegralLimitsTextInitial) {
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
                      "Single Integral",
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
                  hint: "The lower limit of the integral",
                  controller: widget.limitsControllers[0],
                  onChanged: (value) => handlePopupInputChange(),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "The upper limit of the integral",
                  controller: widget.limitsControllers[1],
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
  if(widget.limitsControllers[0].text.isNotEmpty){
    context.read<SingleDefiniteIntegralLimitsTextCubit>().updateLowerLimitText(
          widget.limitsControllers[0].text,
        );
  } 

  if(widget.limitsControllers[1].text.isNotEmpty){
    context.read<SingleDefiniteIntegralLimitsTextCubit>().updateUpperLimitText(
          widget.limitsControllers[1].text,
        );
  }
}
 

  void handleClearButtonPressed() {
    for (var controller in widget.limitsControllers) {
      controller.clear();
    }
    widget.expressionController.clear();
    widget.variableController.clear();
   
    context.read<SingleDefiniteIntegralLimitsTextCubit>().resetText();   
  }

  

  

 void handleInputChange() {
  context.read<SingleFieldsCubit>().checkFieldsReady(
    widget.expressionController.text.isNotEmpty
      );
}



  void handleSubmitButtonPressed() {
    IntegralRequest request = IntegralRequest(
      limits: [
        IntegralLimits(
          lowerLimit: widget.limitsControllers[0].text.isNotEmpty
              ? widget.limitsControllers[0].text
              : "0", // Default lower limit if not provided
          upperLimit: widget.limitsControllers[1].text.isNotEmpty
              ? widget.limitsControllers[1].text
              : "10", // Default upper limit if not provided
        ),
      ],
      expression: widget.expressionController.text,
       variables: widget.variableController.text.isNotEmpty
          ? [widget.variableController.text]
          : ["x"], // Default variable if not provided
          );
    BlocProvider.of<SingleIntegralBloc>(context)
        .add(SingleIntegralRequested(request: request));
    
  }


    
    
  
}

