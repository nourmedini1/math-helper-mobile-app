import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/numeric_derivative/numeric_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/widgets/screens/derivative_initial_screen.dart';
import 'package:math_helper/features/derivatives/presentation/widgets/screens/derivative_success_screen.dart';

class NumericDerivativeScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final TextEditingController variableController;
  final TextEditingController orderController;
  final TextEditingController derivingPointController;

  const NumericDerivativeScreen({super.key, 
    required this.expressionController,
    required this.variableController,
    required this.orderController,
    required this.derivingPointController
  });
  @override
  State<NumericDerivativeScreen> createState() => _NumericDerivativeScreenState();
}

class _NumericDerivativeScreenState extends State<NumericDerivativeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<NumericDerivativeBloc, NumericDerivativeState>(
        listener: (context, state) {
          if (state is NumericDerivativeFailure) {
            showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is NumericDerivativeInitial) {
            return DerivativeInitialScreen(
              isNumeric: false, 
              expressionController: widget.expressionController, 
              variableController: widget.variableController, 
              orderController: widget.orderController);
          } else if (state is NumericDerivativeLoading) {
            return const LoadingScreen();
          } else if (state is NumericDerivativeSuccess) {
            return DerivativeSuccessScreen(
              title: "Numeric Derivative", 
              expression: state.response.derivative, 
              result: state.response.result.toString(), 
              isNumeric: false);
          } else if (state is NumericDerivativeFailure) {
            return DerivativeInitialScreen(
              isNumeric: false, 
              expressionController: widget.expressionController, 
              variableController: widget.variableController, 
              orderController: widget.orderController,
              derivingPointController: widget.derivingPointController);
          }
          return Container();
        },
      ),
    );
  }
   void showToast(BuildContext context, String message) {
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.customRed,
      ),
    );
  }
}