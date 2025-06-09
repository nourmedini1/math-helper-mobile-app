import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_primitive/double_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/widgets/indefinite_integral/double/double_indefinite_integral_initial_screen.dart';
import 'package:math_helper/features/integrals/presentation/widgets/integral_success_screen.dart';

class DoubleIndefiniteIntegralScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final TextEditingController variableController;
  const DoubleIndefiniteIntegralScreen({
    super.key,
    required this.expressionController,
    required this.variableController,
  });

  @override
  State<DoubleIndefiniteIntegralScreen> createState() => _DoubleIndefiniteIntegralScreenState();
}

class _DoubleIndefiniteIntegralScreenState extends State<DoubleIndefiniteIntegralScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<DoublePrimitiveBloc, DoublePrimitiveState>(
        listener: (context, state) {
          if (state is DoublePrimitiveFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is DoublePrimitiveInitial) {
            return DoubleIndefiniteIntegralInitialScreen(
              expressionController: widget.expressionController,
              variableController: widget.variableController,
            );
          } else if (state is DoublePrimitiveLoading) {
            return const LoadingScreen();
          } else if (state is DoublePrimitiveSuccess) {
            return IntegralSuccessScreen(
              title: "Double Primitive",
              integral: state.integralResponse.integral,
              result: state.integralResponse.result,
            );
          }
          return const SizedBox.shrink();
        },
      )
      
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