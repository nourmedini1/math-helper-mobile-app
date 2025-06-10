import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/sum/presentation/bloc/numeric_sum/numeric_sum_bloc.dart';
import 'package:math_helper/features/sum/presentation/widgets/numeric/numeric_sum_initial_screen.dart';
import 'package:math_helper/features/sum/presentation/widgets/sum_success_screen.dart';

class NumericSumScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> boundControllers;
  final TextEditingController variableController;
  const NumericSumScreen({
    super.key,
    required this.expressionController,
    required this.variableController,
    required this.boundControllers,
  });

  @override
  State<NumericSumScreen> createState() => _NumericSumScreenState();
}

class _NumericSumScreenState extends State<NumericSumScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<NumericSumBloc, NumericSumState>(
        listener: (context, state) {
          if (state is NumericSumFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is NumericSumInitial) {
            return NumericSumInitialScreen(
              expressionController: widget.expressionController,
              boundControllers: widget.boundControllers,
              variableController: widget.variableController,
            );
          } else if (state is NumericSumLoading) {
            return const LoadingScreen();
          } else if (state is NumericSumSuccess) {
            return SumSuccessScreen(
              isConvergent: state.response.convergent,
              title: "Numeric Sum",
              sum: state.response.summation,
              result: state.response.result,
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