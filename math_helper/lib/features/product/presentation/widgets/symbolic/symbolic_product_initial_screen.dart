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
import 'package:math_helper/features/product/data/models/product_request.dart';
import 'package:math_helper/features/product/presentation/bloc/symbolic_product/symbolic_product_bloc.dart';
import 'package:math_helper/features/product/presentation/cubit/symbolic/symbolic_product_fields/symbolic_product_fields_cubit.dart';
import 'package:provider/provider.dart';

class SymbolicProductInitialScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final TextEditingController variableController;
  final TextEditingController lowerBoundController;
  const SymbolicProductInitialScreen(
      {super.key,
      required this.expressionController,
      required this.variableController,
      required this.lowerBoundController,
      });

  @override
  State<SymbolicProductInitialScreen> createState() => _SymbolicProductIitialScreenState();
}

class _SymbolicProductIitialScreenState extends State<SymbolicProductInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: "Symbolic Product",
      body: buildBody(),
      submitButton: BlocBuilder<SymbolicProductFieldsCubit, SymbolicProductFieldsState>(
                    builder: (context, state) {
                      if (state is SymbolicProductFieldsReady) {
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
            hint: "The expression of the product",
            controller: widget.expressionController,
            onChanged: (value) => handleInputChange(),
          ),
          CustomTextField(
            label: "The variable",
            hint: "The variable used, default is n",
            controller: widget.variableController,
            onChanged: (value) => () {},
          ),
           CustomTextField(
            label: "The lower bound",
            hint: "The lower bound of the product, default is 0",
            controller: widget.lowerBoundController,
            onChanged: (value) => () {},
          ),
          
          
      
          
        ],
      ),
    );
  }

  
  
 



  void handleClearButtonPressed() {
    widget.expressionController.clear();
    widget.variableController.clear();
    widget.lowerBoundController.clear();
   
    context.read<SymbolicProductFieldsCubit>().reset();  
    
  }

  

  

 void handleInputChange() {
  context.read<SymbolicProductFieldsCubit>().checkAllFieldsReady(
    widget.expressionController.text.isNotEmpty
      );
}



  void handleSubmitButtonPressed() {
    ProductRequest request = ProductRequest(
      expression: widget.expressionController.text,
      variable: widget.variableController.text.isNotEmpty
          ? widget.variableController.text
          : "n",
      lowerLimit: widget.lowerBoundController.text.isNotEmpty
          ? widget.lowerBoundController.text
          : "0", 
      upperLimit: "oo", // Symbolic Products typically don't have an upper limit
          );
    BlocProvider.of<SymbolicProductBloc>(context)
        .add(SymbolicProductRequested(request: request));
    
  }


    
    
  
}

