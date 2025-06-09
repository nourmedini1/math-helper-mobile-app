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
import 'package:math_helper/features/limits/data/models/limit_request.dart';
import 'package:math_helper/features/limits/presentation/bloc/single_limit/single_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/cubit/single/single_limit_fields/single_limit_fields_cubit.dart';
import 'package:math_helper/features/limits/presentation/cubit/single/single_limit_text/single_limit_text_cubit.dart';
import 'package:provider/provider.dart';

class SingleLimitInitialScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> boundControllers;
  final List<TextEditingController> signControllers;
  final TextEditingController variableController;
  const SingleLimitInitialScreen(
      {super.key,
      required this.expressionController,
      required this.variableController,
      required this.boundControllers,
      required this.signControllers,
      });

  @override
  State<SingleLimitInitialScreen> createState() => _SingleLimitInitialScreenState();
}

class _SingleLimitInitialScreenState extends State<SingleLimitInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: "Single Limit",
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
            hint: "The expression to evaluate the limit for",
            controller: widget.expressionController,
            onChanged: (value) => handleInputChange(),
          ),
          CustomTextField(
            label: "The variable",
            hint: "The variable, default is x",
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
                  child: TextFieldLabel(label: "The limit bounds"),
                ),
                BlocBuilder<SingleLimitTextCubit, SingleLimitTextState>(
                  builder: (context, state) {
                    if (state is SingleLimitTextInitial) {
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
                      "Single Limit",
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
                  hint: "The x bound of the limit",
                  controller: widget.boundControllers[0],
                  onChanged: (value) => handlePopupInputChange(),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "The sign of the bound (+/-)",
                  controller: widget.signControllers[0],
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
 context.read<SingleLimitTextCubit>().updateXValue(
          widget.boundControllers[0].text.isEmpty ? "0" : widget.boundControllers[0].text,
        );
  
     context.read<SingleLimitTextCubit>().updateSign(
          widget.signControllers[0].text.isEmpty ? "+" : widget.signControllers[0].text,
        );
}
 

  void handleClearButtonPressed() {
    for (var controller in widget.boundControllers) {
      controller.clear();
    }
    for (var controller in widget.signControllers) {
      controller.clear();
    }
    widget.expressionController.clear();
    widget.variableController.clear();
   
    context.read<SingleLimitTextCubit>().reset();   
  }

  

  

 void handleInputChange() {
  context.read<SingleLimitFieldsCubit>().checkAllFieldsReady(
    widget.expressionController.text.isNotEmpty
      );
}



  void handleSubmitButtonPressed() {
    LimitRequest request = LimitRequest(
      expression: widget.expressionController.text,
      variables: widget.variableController.text.isEmpty ? ["x"] : [widget.variableController.text],
      bounds: [
        Bound(
          value: widget.boundControllers[0].text.isEmpty ? "0" : widget.boundControllers[0].text,
          sign: widget.signControllers[0].text.isEmpty ? "+" : widget.signControllers[0].text,)
      ]
    );
    context.read<SingleLimitBloc>().add(SingleLimitRequested(request: request));
  }


    
    
  
}

