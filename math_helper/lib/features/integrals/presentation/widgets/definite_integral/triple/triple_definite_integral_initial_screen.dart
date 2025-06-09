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
import 'package:math_helper/features/integrals/presentation/bloc/triple_integral/triple_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/cubit/definite_integral/triple_fields/triple_fields_cubit.dart';
import 'package:math_helper/features/integrals/presentation/cubit/definite_integral/triple_limits_text/triple_definite_integral_limit_text_cubit.dart';
import 'package:provider/provider.dart';

class TripleDefiniteIntegralInitialScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> limitsControllers;
  final TextEditingController variableController;
  const TripleDefiniteIntegralInitialScreen(
      {super.key,
      required this.expressionController,
      required this.limitsControllers,
      required this.variableController,
      });

  @override
  State<TripleDefiniteIntegralInitialScreen> createState() => _TripleDefiniteIntegralInitialScreenState();
}

class _TripleDefiniteIntegralInitialScreenState extends State<TripleDefiniteIntegralInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: "Triple Integral",
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
            hint: "The variable of integration, default is x,y,z",
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
                BlocBuilder<TripleDefiniteIntegralLimitTextCubit, TripleDefiniteIntegralLimitTextState>(
                  builder: (context, state) {
                    if (state is TripleDefiniteIntegralLimitTextInitial) {
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
                      "Triple Integral",
                      style: TextStyle(
                        color: Provider.of<ThemeManager>(context, listen: false)
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 8),
                      child: TextFieldLabel(
                        label: "The x limits of integration",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 140,
                          child: CustomTextField(
                            hint: "The lower x",
                            controller: widget.limitsControllers[0],
                            onChanged: (value) => handlePopupInputChange(),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: CustomTextField(
                            hint: "The upper x",
                            controller: widget.limitsControllers[1],
                            onChanged: (value) => handlePopupInputChange(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 8),
                      child: TextFieldLabel(
                        label: "The y limits of integration",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 140,
                          child: CustomTextField(
                            hint: "The lower y",
                            controller: widget.limitsControllers[2],
                            onChanged: (value) => handlePopupInputChange(),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: CustomTextField(
                            hint: "The upper y",
                            controller: widget.limitsControllers[3],
                            onChanged: (value) => handlePopupInputChange(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 8),
                      child: TextFieldLabel(
                        label: "The z limits of integration",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 140,
                          child: CustomTextField(
                            hint: "The lower z",
                            controller: widget.limitsControllers[4],
                            onChanged: (value) => handlePopupInputChange(),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: CustomTextField(
                            hint: "The upper z",
                            controller: widget.limitsControllers[5],
                            onChanged: (value) => handlePopupInputChange(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                  child: SubmitButton(
                    text: "Confirm",
                    icon: Icons.check,
                    color: Provider.of<ThemeManager>(context).themeData ==
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
  if(widget.limitsControllers[0].text.isNotEmpty) {
     context.read<TripleDefiniteIntegralLimitTextCubit>().updateLowerLimitXText(
          widget.limitsControllers[0].text,
        );
  }

  if(widget.limitsControllers[1].text.isNotEmpty) {
     context.read<TripleDefiniteIntegralLimitTextCubit>().updateUpperLimitXText(
          widget.limitsControllers[1].text,
        );
  }

  if(widget.limitsControllers[2].text.isNotEmpty) {
     context.read<TripleDefiniteIntegralLimitTextCubit>().updateLowerLimitYText(
          widget.limitsControllers[2].text,
        );
  }

  if(widget.limitsControllers[3].text.isNotEmpty) {
     context.read<TripleDefiniteIntegralLimitTextCubit>().updateUpperLimitYText(
          widget.limitsControllers[3].text,
        );
  }

  if(widget.limitsControllers[4].text.isNotEmpty) {
     context.read<TripleDefiniteIntegralLimitTextCubit>().updateLowerLimitZText(
          widget.limitsControllers[4].text,
        );
  }

  if(widget.limitsControllers[5].text.isNotEmpty) {
     context.read<TripleDefiniteIntegralLimitTextCubit>().updateUpperLimitZText(
          widget.limitsControllers[5].text,
        );
  }
}
 

  void handleClearButtonPressed() {
    for (var controller in widget.limitsControllers) {
      controller.clear();
    }
    widget.expressionController.clear();
    widget.variableController.clear();
   
    context.read<TripleDefiniteIntegralLimitTextCubit>().resetText();   
  }

  

  

 void handleInputChange() {
  context.read<TripleFieldsCubit>().checkFieldsReady(
    widget.expressionController.text.isNotEmpty
      );
}



  void handleSubmitButtonPressed() {
    IntegralRequest request = IntegralRequest(
      limits: [
        IntegralLimits(
          lowerLimit: widget.limitsControllers[0].text.isEmpty ? "0" : widget.limitsControllers[0].text,
          upperLimit: widget.limitsControllers[1].text.isEmpty ? "10" : widget.limitsControllers[1].text,
        ),
        IntegralLimits(
          lowerLimit: widget.limitsControllers[2].text.isEmpty ? "0" : widget.limitsControllers[2].text,
          upperLimit: widget.limitsControllers[3].text.isEmpty ? "10" : widget.limitsControllers[3].text,
        ),
        IntegralLimits(
          lowerLimit: widget.limitsControllers[4].text.isEmpty ? "0" : widget.limitsControllers[4].text,
          upperLimit: widget.limitsControllers[5].text.isEmpty ? "10" : widget.limitsControllers[5].text,
        ),
      ],
       
      expression: widget.expressionController.text,
       variables: widget.variableController.text.isNotEmpty
          ? widget.variableController.text.split(",").map((e) => e.trim()).toList()
          : ["x","y","z"], // Default variable if not provided
          );
    BlocProvider.of<TripleIntegralBloc>(context)
        .add(TripleIntegralRequested(request: request));
    
  }


    
    
  
}

