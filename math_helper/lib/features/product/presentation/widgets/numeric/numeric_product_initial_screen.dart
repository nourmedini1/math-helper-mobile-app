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
import 'package:math_helper/features/product/data/models/product_request.dart';
import 'package:math_helper/features/product/presentation/bloc/numeric_product/numeric_product_bloc.dart';
import 'package:math_helper/features/product/presentation/cubit/numeric/numeric_product_fields/numeric_product_fields_cubit.dart';
import 'package:math_helper/features/product/presentation/cubit/numeric/numeric_product_text/numeric_product_text_cubit.dart';
import 'package:provider/provider.dart';

class NumericProductInitialScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> boundControllers;
  final TextEditingController variableController;
  const NumericProductInitialScreen(
      {super.key,
      required this.expressionController,
      required this.variableController,
      required this.boundControllers,
      });

  @override
  State<NumericProductInitialScreen> createState() => _NumericProductInitialScreenState();
}

class _NumericProductInitialScreenState extends State<NumericProductInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: "Numeric Product",
      body: buildBody(),
      submitButton:BlocBuilder<NumericProductFieldsCubit, NumericProductFieldsState>(
                    builder: (context, state) {
                      if (state is NumericProductFieldsReady) {
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
            hint: "The expression to evaluate the product for",
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
                  child: TextFieldLabel(label: "The product bounds"),
                ),
                BlocBuilder<NumericProductTextCubit, NumericProductTextState>(
                  builder: (context, state) {
                    if (state is NumericProductTextInitial) {
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
                      "Numeric Product",
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
                  hint: "The lower bound of the product",
                  controller: widget.boundControllers[0],
                  onChanged: (value) => handlePopupInputChange(),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "The upper bound of the product",
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
 context.read<NumericProductTextCubit>().updateLowerLimit(
          widget.boundControllers[0].text.isEmpty ? "0" : widget.boundControllers[0].text,
        );
  
     context.read<NumericProductTextCubit>().updateUpperLimit(
          widget.boundControllers[1].text.isEmpty ? "oo" : widget.boundControllers[1].text,
        );
}
 

  void handleClearButtonPressed() {
    for (var controller in widget.boundControllers) {
      controller.clear();
    }
    widget.expressionController.clear();
    widget.variableController.clear();
   
    context.read<NumericProductTextCubit>().reset();   
    context.read<NumericProductFieldsCubit>().reset();
  }

  

  

 void handleInputChange() {
  context.read<NumericProductFieldsCubit>().checkAllFieldsReady(
    widget.expressionController.text.isNotEmpty
      );
}



  void handleSubmitButtonPressed() {
   final ProductRequest request = ProductRequest(
      expression: widget.expressionController.text,
      variable: widget.variableController.text.isEmpty ? "n" : widget.variableController.text,
      lowerLimit: widget.boundControllers[0].text.isEmpty ? "0" : widget.boundControllers[0].text,
      upperLimit: widget.boundControllers[1].text.isEmpty ? "oo" : widget.boundControllers[1].text,
    );
    context.read<NumericProductBloc>().add(NumericProductRequested(request: request));
  }


    
    
  
}

