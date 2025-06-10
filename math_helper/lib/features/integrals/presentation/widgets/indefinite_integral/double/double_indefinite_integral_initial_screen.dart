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
import 'package:math_helper/features/integrals/presentation/bloc/double_primitive/double_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/cubit/indefinite_integral/indefinite_double_fields/indefinite_double_fields_cubit.dart';
import 'package:provider/provider.dart';

class DoubleIndefiniteIntegralInitialScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final TextEditingController variableController;
  const DoubleIndefiniteIntegralInitialScreen(
      {super.key,
      required this.expressionController,
      required this.variableController,
      });

  @override
  State<DoubleIndefiniteIntegralInitialScreen> createState() => _DoubleIndefiniteIntegralInitialScreenState();
}

class _DoubleIndefiniteIntegralInitialScreenState extends State<DoubleIndefiniteIntegralInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: "Double Primitive",
      body: buildBody(),
      submitButton: BlocBuilder<IndefiniteDoubleFieldsCubit, IndefiniteDoubleFieldsState>(
                    builder: (context, state) {
                      if (state is IndefiniteDoubleFieldsReady) {
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
            hint: "The variable of integration, default is x,y",
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
   
    context.read<IndefiniteDoubleFieldsCubit>().reset();   

  }

  

  

 void handleInputChange() {
  context.read<IndefiniteDoubleFieldsCubit>().checkFieldsReady(
    widget.expressionController.text.isNotEmpty
      );
}



  void handleSubmitButtonPressed() {
    IntegralRequest request = IntegralRequest(
      expression: widget.expressionController.text,
       variables: widget.variableController.text.isNotEmpty
          ? widget.variableController.text.split(",").map((e) => e.trim()).toList()
          : ["x","y"], // Default variable if not provided
          );
    BlocProvider.of<DoublePrimitiveBloc>(context)
        .add(DoublePrimitiveRequested(request: request));
    
  }


    
    
  
}

