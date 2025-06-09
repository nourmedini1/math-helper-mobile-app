import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_primitive/single_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/widgets/indefinite_integral/single/single_indefinite_integral_initial_screen.dart';
import 'package:math_helper/features/integrals/presentation/widgets/integral_success_screen.dart';

class SingleIndefiniteIntegralScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final TextEditingController variableController;
  const SingleIndefiniteIntegralScreen({
    super.key,
    required this.expressionController,
    required this.variableController,
  });

  @override
  State<SingleIndefiniteIntegralScreen> createState() => _SingleIndefiniteIntegralScreenState();
}

class _SingleIndefiniteIntegralScreenState extends State<SingleIndefiniteIntegralScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<SinglePrimitiveBloc, SinglePrimitiveState>(
        listener: (context, state) {
          if (state is SinglePrimitiveFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is SinglePrimitiveInitial) {
            return SingleIndefiniteIntegralInitialScreen(
              expressionController: widget.expressionController,
              variableController: widget.variableController,
            );
          } else if (state is SinglePrimitiveLoading) {
            return const LoadingScreen();
          } else if (state is SinglePrimitiveSuccess) {
            return IntegralSuccessScreen(
              title: "Single Primitive",
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