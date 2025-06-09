import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_integral/double_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/widgets/definite_integral/double/double_definite_integral_initial_screen.dart';
import 'package:math_helper/features/integrals/presentation/widgets/integral_success_screen.dart';

class DoubleDefiniteIntegralScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> limitsControllers;
  final TextEditingController variableController;
  const DoubleDefiniteIntegralScreen({
    super.key,
    required this.expressionController,
    required this.limitsControllers,
    required this.variableController,
  });

  @override
  State<DoubleDefiniteIntegralScreen> createState() => _DoubleDefiniteIntegralScreenState();
}

class _DoubleDefiniteIntegralScreenState extends State<DoubleDefiniteIntegralScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<DoubleIntegralBloc, DoubleIntegralState>(
        listener: (context, state) {
          if (state is DoubleIntegralFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is DoubleIntegralInitial) {
            return DoubleDefiniteIntegralInitialScreen(
              expressionController: widget.expressionController,
              limitControllers: widget.limitsControllers,
              variableController: widget.variableController,
            );
          } else if (state is DoubleIntegralLoading) {
            return const LoadingScreen();
          } else if (state is DoubleIntegralSuccess) {
            return IntegralSuccessScreen(
              title: "Double Integral",
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