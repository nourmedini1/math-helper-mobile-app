// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/first_order_differential_equation/first_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/widgets/screens/first_order_ode/first_order_ode_initial_screen.dart';
import 'package:math_helper/features/differential_equations/presentation/widgets/screens/ode_success_screen.dart';

class FirstOrderOdeScreen extends StatefulWidget {
  final List<TextEditingController> coefficientControllers;
  final List<TextEditingController> initialConditionControllers;
  final TextEditingController constantController;
  final TextEditingController RHSController;
  const FirstOrderOdeScreen({super.key,
      required this.coefficientControllers,
      required this.initialConditionControllers,
      required this.constantController,
      required this.RHSController});

  @override
  State<FirstOrderOdeScreen> createState() => _FirstOrderOdeScreenState();
}

class _FirstOrderOdeScreenState extends State<FirstOrderOdeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<FirstOrderDifferentialEquationBloc, FirstOrderDifferentialEquationState>(
        listener: (context, state) {
         if (state is FirstOrderDifferentialEquationFailure) {
           showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is FirstOrderDifferentialEquationInitial) {
            return FirstOrderOdeInitialScreen(
              coefficientControllers: widget.coefficientControllers, 
              initialConditionControllers: widget.initialConditionControllers, 
              constantController: widget.constantController, 
              RHSController: widget.RHSController);
          } else if (state is FirstOrderDifferentialEquationLoading) {
            return const LoadingScreen();
          } else if (state is FirstOrderDifferentialEquationSuccess) {
            return OdeSuccessScreen(
              title: "First Order ODE",
              expression: state.response.equation,
              result: state.response.solution,
            );
          } else if (state is FirstOrderDifferentialEquationFailure) {
            return FirstOrderOdeInitialScreen(
              coefficientControllers: widget.coefficientControllers, 
              initialConditionControllers: widget.initialConditionControllers, 
              constantController: widget.constantController, 
              RHSController: widget.RHSController);
          }
          return const SizedBox.shrink();
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