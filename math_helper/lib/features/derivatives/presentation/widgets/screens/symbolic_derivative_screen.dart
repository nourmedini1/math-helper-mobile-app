import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/derivatives/presentation/bloc/symbolic_derivative/symbolic_derivative_bloc.dart';
import 'package:math_helper/features/derivatives/presentation/widgets/screens/derivative_initial_screen.dart';
import 'package:math_helper/features/derivatives/presentation/widgets/screens/derivative_success_screen.dart';

class SymbolicDerivativeScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final TextEditingController variableController;
  final TextEditingController orderController;

  const SymbolicDerivativeScreen({super.key, 
    required this.expressionController,
    required this.variableController,
    required this.orderController,
  });
  @override
  State<SymbolicDerivativeScreen> createState() => _SymbolicDerivativeScreenState();
}

class _SymbolicDerivativeScreenState extends State<SymbolicDerivativeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<SymbolicDerivativeBloc, SymbolicDerivativeState>(
        listener: (context, state) {
          if (state is SymbolicDerivativeFailure) {
            showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is SymbolicDerivativeInitial) {
            return DerivativeInitialScreen(
              isNumeric: false, 
              expressionController: widget.expressionController, 
              variableController: widget.variableController, 
              orderController: widget.orderController);
          } else if (state is SymbolicDerivativeLoading) {
            return const LoadingScreen();
          } else if (state is SymbolicDerivativeSuccess) {
            return DerivativeSuccessScreen(
              title: "Symbolic Derivative", 
              expression: state.response.derivative, 
              result: state.response.result.toString(), 
              isNumeric: false);
          } else if (state is SymbolicDerivativeFailure) {
            return DerivativeInitialScreen(
              isNumeric: false, 
              expressionController: widget.expressionController, 
              variableController: widget.variableController, 
              orderController: widget.orderController);
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