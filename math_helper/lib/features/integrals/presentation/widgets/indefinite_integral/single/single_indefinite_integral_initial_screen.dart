// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/clear_button.dart';
import 'package:math_helper/core/ui/components/custom_text_field.dart';
import 'package:math_helper/core/ui/components/input_container.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_primitive/single_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/cubit/indefinite_integral/indefinite_single_fields/indefinite_single_fields_cubit.dart';
import 'package:provider/provider.dart';

class SingleIndefiniteIntegralInitialScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final TextEditingController variableController;
  const SingleIndefiniteIntegralInitialScreen(
      {super.key,
      required this.expressionController,
      required this.variableController,
      });

  @override
  State<SingleIndefiniteIntegralInitialScreen> createState() => _SingleIndefiniteIntegralIitialScreenState();
}

class _SingleIndefiniteIntegralIitialScreenState extends State<SingleIndefiniteIntegralInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: "Single Primitive",
      body: buildBody(),
      submitButton: BlocBuilder<IndefiniteSingleFieldsCubit, IndefiniteSingleFieldsState>(
                    builder: (context, state) {
                      if (state is IndefiniteSingleFieldsReady) {
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
          
          
      
          
        ],
      ),
    );
  }

  
  
 



  void handleClearButtonPressed() {
    widget.expressionController.clear();
    widget.variableController.clear();
   
    context.read<IndefiniteSingleFieldsCubit>().reset();  
    
  }

  

  

 void handleInputChange() {
  context.read<IndefiniteSingleFieldsCubit>().checkFieldsReady(
    widget.expressionController.text.isNotEmpty
      );
}



  void handleSubmitButtonPressed() {
    IntegralRequest request = IntegralRequest(
      expression: widget.expressionController.text,
       variables: widget.variableController.text.isNotEmpty
          ? [widget.variableController.text]
          : ["x"], // Default variable if not provided
          );
    BlocProvider.of<SinglePrimitiveBloc>(context)
        .add(SinglePrimitiveRequested(request: request));
    
  }


    
    
  
}

