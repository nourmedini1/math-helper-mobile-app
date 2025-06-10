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
import 'package:math_helper/features/limits/presentation/bloc/double_limit/double_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/cubit/double/double_limit_fields/double_limit_fields_cubit.dart';
import 'package:math_helper/features/limits/presentation/cubit/double/double_limit_text/double_limit_text_cubit.dart';
import 'package:provider/provider.dart';

class DoubleLimitInitialScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> boundControllers;
  final List<TextEditingController> signControllers;
  final TextEditingController variableController;
  const DoubleLimitInitialScreen(
      {super.key,
      required this.expressionController,
      required this.variableController,
      required this.boundControllers,
      required this.signControllers,
      });

  @override
  State<DoubleLimitInitialScreen> createState() => _DoubleLimitInitialScreenState();
}

class _DoubleLimitInitialScreenState extends State<DoubleLimitInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      title: "Double Limit",
      body: buildBody(),
      submitButton: BlocBuilder<DoubleLimitFieldsCubit, DoubleLimitFieldsState>(
                    builder: (context, state) {
                      if (state is DoubleLimitFieldsReady) {
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
            hint: "The expression to evaluate the limit for",
            controller: widget.expressionController,
            onChanged: (value) => handleInputChange(),
          ),
          CustomTextField(
            label: "The variable",
            hint: "The variable, default is x,y",
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
                BlocBuilder<DoubleLimitTextCubit, DoubleLimitTextState>(
                  builder: (context, state) {
                    if (state is DoubleLimitTextInitial) {
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
                      "Double Limit",
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
                        label: "The x bound",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 140,
                          child: CustomTextField(
                            hint: "The x bound value",
                            controller: widget.boundControllers[0],
                            onChanged: (value) => handlePopupInputChange(),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: CustomTextField(
                            hint: "The sign of x",
                            controller: widget.signControllers[0],
                            onChanged: (value) => handlePopupInputChange(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 8),
                      child: TextFieldLabel(
                        label: "The y bound",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 140,
                          child: CustomTextField(
                            hint: "The y bound value",
                            controller: widget.boundControllers[1],
                            onChanged: (value) => handlePopupInputChange(),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: CustomTextField(
                            hint: "The sign of y",
                            controller: widget.signControllers[1],
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
    context.read<DoubleLimitTextCubit>().updateXValue(
          widget.boundControllers[0].text.isEmpty ? "0" : widget.boundControllers[0].text,
        );

    context.read<DoubleLimitTextCubit>().updateSignY(
          widget.boundControllers[1].text.isEmpty ? "0" : widget.boundControllers[1].text,
        );
  
    context.read<DoubleLimitTextCubit>().updateSignX(
          widget.signControllers[0].text.isEmpty ? "+" : widget.signControllers[0].text,
        );
    context.read<DoubleLimitTextCubit>().updateSignY(
          widget.signControllers[1].text.isEmpty ? "+" : widget.signControllers[1].text,
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
   
    context.read<DoubleLimitTextCubit>().reset();  
    context.read<DoubleLimitFieldsCubit>().reset(); 
  }

  

  

 void handleInputChange() {
  context.read<DoubleLimitFieldsCubit>().checkAllFieldsReady(
    widget.expressionController.text.isNotEmpty
      );
}



  void handleSubmitButtonPressed() {
    LimitRequest request = LimitRequest(
      expression: widget.expressionController.text,
      variables: widget.variableController.text.isEmpty ? ["x","y"] : [widget.variableController.text],
      bounds: [
        Bound(
          value: widget.boundControllers[0].text.isEmpty ? "0" : widget.boundControllers[0].text,
          sign: widget.signControllers[0].text.isEmpty ? "+" : widget.signControllers[0].text,),
        Bound(
          value: widget.boundControllers[1].text.isEmpty ? "0" : widget.boundControllers[1].text,
          sign: widget.signControllers[1].text.isEmpty ? "+" : widget.signControllers[1].text,),
      ]
    );
    context.read<DoubleLimitBloc>().add(DoubleLimitRequested(request: request));
  }


    
    
  
}

