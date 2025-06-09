import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/clear_button.dart';
import 'package:math_helper/core/ui/components/custom_switch.dart';
import 'package:math_helper/core/ui/components/custom_text_field.dart';
import 'package:math_helper/core/ui/components/input_container.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_request.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/numeric_derivative/numeric_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/symbolic_derivative/symbolic_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/cubit/numeric_derivative_fields/numeric_derivative_fields_cubit.dart';
import 'package:math_helper/features/derivatives/presentation/cubit/numeric_partial_derivative/numeric_partial_derivative_cubit.dart';
import 'package:math_helper/features/derivatives/presentation/cubit/symbolic_derivative_fields/symbolic_derivative_fields_cubit.dart';
import 'package:math_helper/features/derivatives/presentation/cubit/symbolic_partial_derivative/symbolic_partial_derivative_cubit.dart';
import 'package:provider/provider.dart';

class DerivativeInitialScreen extends StatefulWidget {
  final bool isNumeric;
  final TextEditingController expressionController;
  final TextEditingController variableController;
  final TextEditingController orderController;
  final TextEditingController? derivingPointController;
  const DerivativeInitialScreen({super.key, 
    required this.isNumeric,
    required this.expressionController,
    required this.variableController,
    required this.orderController,
    this.derivingPointController,
  });

  @override
  State<DerivativeInitialScreen> createState() => _DerivativeInitialScreenState();
}

class _DerivativeInitialScreenState extends State<DerivativeInitialScreen> {
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [
      widget.expressionController,
      widget.variableController,
      widget.orderController,
    ] + (widget.derivingPointController != null 
        ? [widget.derivingPointController!] 
        : []);
    return InputContainer(
      title: widget.isNumeric ? "Numeric Derivative" : "Symbolic Derivative",
      body: widgetBody(controllers),
      submitButton: buildSubmitButton(),
      clearButton: ClearButton(
        onPressed: () => handleClearButtonPressed(controllers),
      ),
      );
  }

  BlocBuilder buildSubmitButton() {
    final themeManager = Provider.of<ThemeManager>(context, listen: false);
    final activeColor = themeManager.themeData == AppThemeData.lightTheme
        ? AppColors.primaryColorTint50
        : AppColors.primaryColor;
    if (widget.isNumeric) {
      return BlocBuilder<NumericDerivativeFieldsCubit, NumericDerivativeFieldsState>(
        builder: (context, state) {
          final isEnabled = state is NumericDerivativeFieldsReady;
          return SubmitButton(
            color: isEnabled ? activeColor : AppColors.customBlackTint80,
            onPressed: isEnabled ? () => handleSubmitButtonPressed(context) : () {},
          );
        },
      );
    } else {
      return BlocBuilder<SymbolicDerivativeFieldsCubit, SymbolicDerivativeFieldsState>(
        builder: (context, state) {
          final isEnabled = state is SymbolicDerivativeFieldsReady;
          return SubmitButton(
            color: isEnabled ? activeColor : AppColors.customBlackTint80,
            onPressed: isEnabled ? () => handleSubmitButtonPressed(context) : () {},
          );
        },
      );
    }
  }

  Widget widgetBody(List<TextEditingController> controllers) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: "The expression",
            controller: widget.expressionController,
            hint: "Example: cos(x)/(1 + sin(x))", 
            onChanged: (value) => handleInputChange(widget.isNumeric),),
          CustomTextField(
            label: "The variable",
            controller: widget.variableController,
            hint: "The variable used, default is x",
            onChanged: (value) => handleInputChange(
              widget.isNumeric)),
          CustomTextField(
            label: "The order of the differentiation",
            controller: widget.orderController,
            hint: "Must be 1 or greater, default is 1",
            keyboardType: TextInputType.number,
            onChanged: (value) => handleInputChange(widget.isNumeric)),
          widget.isNumeric
              ? CustomTextField(
                  label: "The deriving point",
                  controller: widget.derivingPointController!,
                  hint: "Example: 2.5",
                  onChanged: (value) => handleInputChange(widget.isNumeric),
                )
              : const SizedBox.shrink(),
          buildPartialDerivativeSwitch(widget.isNumeric),
        ]
      ),
    );
  }

  Widget buildPartialDerivativeSwitch(bool isNumeric) {
  final isLight = Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme;

  return isNumeric
      ? BlocBuilder<NumericPartialDerivativeCubit, NumericPartialDerivativeState>(
          builder: (context, state) => _partialSwitch(
            value: state is NumericPartialDerivativeOn,
            onToggle: () => context.read<NumericPartialDerivativeCubit>().toggle(),
            isLight: isLight,
          ),
        )
      : BlocBuilder<SymbolicPartialDerivativeCubit, SymbolicPartialDerivativeState>(
          builder: (context, state) => _partialSwitch(
            value: state is SymbolicPartialDerivativeOn,
            onToggle: () => context.read<SymbolicPartialDerivativeCubit>().toggle(),
            isLight: isLight,
          ),
        );
}

Widget _partialSwitch({required bool value, required VoidCallback onToggle, required bool isLight}) {
  return CustomSwitch(
    value: value,
    label: "Partial Derivative?",
    onChanged: (_) => onToggle(),
    isLight: isLight,
  );
}

  void handleInputChange(bool isNumeric) {
    if (widget.isNumeric) {
      context.read<NumericDerivativeFieldsCubit>().checkFieldsReady(
        widget.expressionController.text.isNotEmpty &&
        widget.derivingPointController!.text.isNotEmpty,
      );
    } else {
      context.read<SymbolicDerivativeFieldsCubit>().checkFieldsReady(
        widget.expressionController.text.isNotEmpty 
       
      );
    }
  }

  void handleSubmitButtonPressed(BuildContext context) {
    if (widget.isNumeric) {
      final isPartialNumeric = context.read<NumericPartialDerivativeCubit>().isOn();
      final request = DerivativeRequest(
              expression: widget.expressionController.text,
              variable: widget.variableController.text.isEmpty
                  ? "x" // Default variable if not provided
                  : widget.variableController.text,
              order: int.parse(widget.orderController.text) > 0
                  ? int.parse(widget.orderController.text)
                  : 1, // Default order if not provided or invalid
              derivingPoint: widget.derivingPointController?.text,
              partial: isPartialNumeric);
        BlocProvider.of<NumericDerivativeBloc>(context)
              .add(NumericDerivativeRequested(request: request));
    } else {
      final isPartialSymbolic = context.read<SymbolicPartialDerivativeCubit>().isOn();
      final request = DerivativeRequest(
              expression: widget.expressionController.text,
              variable: widget.variableController.text.isEmpty
                  ? "x" // Default variable if not provided
                  : widget.variableController.text,
              order: widget.orderController.text.isNotEmpty &&
                      int.tryParse(widget.orderController.text) != null &&
                      int.parse(widget.orderController.text) > 0
                  ? int.parse(widget.orderController.text)
                  : 1, // Default order if not provided or invalid
              partial: isPartialSymbolic);
        BlocProvider.of<SymbolicDerivativeBloc>(context)
            .add(SymbolicDerivativeRequested(request: request));
    }
  }

  void handleClearButtonPressed(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      controller.clear();
    }
    if (widget.isNumeric) {
      context.read<NumericDerivativeFieldsCubit>().checkFieldsReady(false);
      context.read<NumericPartialDerivativeCubit>().turnOff();
    } else {
      context.read<SymbolicDerivativeFieldsCubit>().checkFieldsReady(false);
      context.read<SymbolicPartialDerivativeCubit>().turnOff();
    }
  }
}