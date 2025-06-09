import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_primitive/triple_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/widgets/indefinite_integral/triple/triple_indefinite_integral_initial_screen.dart';
import 'package:math_helper/features/integrals/presentation/widgets/integral_success_screen.dart';

class TripleIndefiniteIntegralScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final TextEditingController variableController;
  const TripleIndefiniteIntegralScreen({
    super.key,
    required this.expressionController,
    required this.variableController,
  });

  @override
  State<TripleIndefiniteIntegralScreen> createState() => _TripleIndefiniteIntegralScreenState();
}

class _TripleIndefiniteIntegralScreenState extends State<TripleIndefiniteIntegralScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<TriplePrimitiveBloc, TriplePrimitiveState>(
        listener: (context, state) {
          if (state is TriplePrimitiveFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is TriplePrimitiveInitial) {
            return TripleIndefiniteIntegralInitialScreen(
              expressionController: widget.expressionController,
              variableController: widget.variableController,
            );
          } else if (state is TriplePrimitiveLoading) {
            return const LoadingScreen();
          } else if (state is TriplePrimitiveSuccess) {
            return IntegralSuccessScreen(
              title: "Triple Primitive",
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