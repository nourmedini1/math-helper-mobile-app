// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/third_order_differential_equation/third_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/widgets/screens/third_order_ode/third_order_initial_screen.dart';
import 'package:math_helper/features/differential_equations/presentation/widgets/screens/ode_success_screen.dart';

class ThirdOrderOdeScreen extends StatefulWidget {
  final List<TextEditingController> coefficientControllers;
  final List<TextEditingController> initialConditionControllers;
  final TextEditingController constantController;
  final TextEditingController RHSController;
  const ThirdOrderOdeScreen({super.key,
      required this.coefficientControllers,
      required this.initialConditionControllers,
      required this.constantController,
      required this.RHSController});

  @override
  State<ThirdOrderOdeScreen> createState() => _ThirdOrderOdeScreenState();
}

class _ThirdOrderOdeScreenState extends State<ThirdOrderOdeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<ThirdOrderDifferentialEquationBloc, ThirdOrderDifferentialEquationState>(
        listener: (context, state) {
         if (state is ThirdOrderDifferentialEquationFailure) {
           showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ThirdOrderDifferentialEquationInitial) {
            return ThirdOrderOdeInitialScreen(
              coefficientControllers: widget.coefficientControllers, 
              initialConditionControllers: widget.initialConditionControllers, 
              constantController: widget.constantController, 
              RHSController: widget.RHSController);
          } else if (state is ThirdOrderDifferentialEquationLoading) {
            return const LoadingScreen();
          } else if (state is ThirdOrderDifferentialEquationSuccess) {
            return OdeSuccessScreen(
              title: "Third Order ODE",
              expression: state.response.equation,
              result: state.response.solution,
            );
          } else if (state is ThirdOrderDifferentialEquationFailure) {
            return ThirdOrderOdeInitialScreen(
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