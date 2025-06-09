import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_integral/single_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/widgets/definite_integral/single/single_definite_integral_initial_screen.dart';
import 'package:math_helper/features/integrals/presentation/widgets/integral_success_screen.dart';

class SingleDefiniteIntegralScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> limitsControllers;
  final TextEditingController variableController;
  const SingleDefiniteIntegralScreen({
    super.key,
    required this.expressionController,
    required this.limitsControllers,
    required this.variableController,
  });

  @override
  State<SingleDefiniteIntegralScreen> createState() => _SingleDefiniteIntegralScreenState();
}

class _SingleDefiniteIntegralScreenState extends State<SingleDefiniteIntegralScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<SingleIntegralBloc, SingleIntegralState>(
        listener: (context, state) {
          if (state is SingleIntegralFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is SingleIntegralInitial) {
            return SingleDefiniteIntegralInitialScreen(
              expressionController: widget.expressionController,
              limitsControllers: widget.limitsControllers,
              variableController: widget.variableController,
            );
          } else if (state is SingleIntegralLoading) {
            return const LoadingScreen();
          } else if (state is SingleIntegralSuccess) {
            return IntegralSuccessScreen(
              title: "Single Integral",
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