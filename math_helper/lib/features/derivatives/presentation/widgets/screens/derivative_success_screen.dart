import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/numeric_derivative/numeric_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/symbolic_derivative/symbolic_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/widgets/derivative_success_widget.dart';

class DerivativeSuccessScreen extends StatelessWidget {
  final String title;
  final String expression;
  final String result;
  final bool isNumeric;
  const DerivativeSuccessScreen({super.key, required this.title, required this.expression, required this.result, required this.isNumeric});

  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      DerivativeSuccessWidget(
        title: title,
        expression: expression,
        result: result, 
        ),
        const SizedBox(height: 20),
      ResetButton(
        onPressed: () => handleResetButtonPressed(context, isNumeric),
        ),
    ]

  );
  }

  void handleResetButtonPressed(BuildContext context, bool isNumeric) {
    if (isNumeric) {
      BlocProvider.of<NumericDerivativeBloc>(context, listen: false).
          add(const NumericDerivativeReset());
    } else {
      BlocProvider.of<SymbolicDerivativeBloc>(context, listen: false).
          add(const SymbolicDerivativeReset());
    }
  }


}