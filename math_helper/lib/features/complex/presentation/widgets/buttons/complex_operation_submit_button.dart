import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/complex/presentation/cubit/addition_cubit/addition_cubit.dart';
import 'package:math_helper/features/complex/presentation/cubit/multiplication_cubit/multiplication_cubit.dart';
import 'package:math_helper/features/complex/presentation/cubit/substraction_cubit/substraction_cubit.dart';
import 'package:provider/provider.dart';

class ComplexOperationSubmitButton extends StatefulWidget {
  final String operation;
  final List<TextEditingController> controllers;
  final void Function() onSubmitButtonPressed;
  const ComplexOperationSubmitButton({super.key, required this.operation, required this.controllers, required this.onSubmitButtonPressed});

  @override
  State<ComplexOperationSubmitButton> createState() => _ComplexOperationSubmitButtonState();
}

class _ComplexOperationSubmitButtonState extends State<ComplexOperationSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return buildComplexSubmitButton(context, widget.operation, widget.controllers);
  }

  Widget buildComplexSubmitButton(
  BuildContext context,
  String operation,
  List<TextEditingController> controllers,
  

) {
  final themeManager = Provider.of<ThemeManager>(context, listen: false);
  final activeColor = themeManager.themeData == AppThemeData.lightTheme
      ? AppColors.primaryColorTint50
      : AppColors.primaryColor;

  Widget buildButton(bool enabled) => SubmitButton(
        color: enabled ? activeColor : AppColors.customBlackTint60,
        onPressed: enabled
            ? widget.onSubmitButtonPressed
            : () {},
      );

  final cubitBuilders = {
    "Complex Addition": BlocBuilder<AdditionCubit, AdditionState>(
      builder: (context, state) =>
          buildButton(state is AdditionFieldsReady),
    ),
    "Complex Substraction": BlocBuilder<SubstractionCubit, SubstractionState>(
      builder: (context, state) =>
          buildButton(state is SubstractionFieldsReady),
    ),
    "Complex Multiplication": BlocBuilder<MultiplicationCubit, MultiplicationState>(
      builder: (context, state) =>
          buildButton(state is MultiplicationFieldsReady),
    ),
  };

  return cubitBuilders[operation] ??
      buildButton(false);
}

  
}