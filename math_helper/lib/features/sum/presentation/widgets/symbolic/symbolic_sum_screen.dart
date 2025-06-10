import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/sum/presentation/bloc/symbolic_sum/symbolic_sum_bloc.dart';
import 'package:math_helper/features/sum/presentation/widgets/symbolic/symbolic_sum_initial_screen.dart';
import 'package:math_helper/features/sum/presentation/widgets/sum_success_screen.dart';

class SymbolicSumScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final TextEditingController lowerBoundController;
  final TextEditingController variableController;
  const SymbolicSumScreen({
    super.key,
    required this.expressionController,
    required this.variableController,
    required this.lowerBoundController,
  });

  @override
  State<SymbolicSumScreen> createState() => _SymbolicSumScreenState();
}

class _SymbolicSumScreenState extends State<SymbolicSumScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<SymbolicSumBloc, SymbolicSumState>(
        listener: (context, state) {
          if (state is SymbolicSumFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is SymbolicSumInitial) {
            return SymbolicSumInitialScreen(
              expressionController: widget.expressionController,
              lowerBoundController: widget.lowerBoundController,
              variableController: widget.variableController,
            );
          } else if (state is SymbolicSumLoading) {
            return const LoadingScreen();
          } else if (state is SymbolicSumSuccess) {
            return SumSuccessScreen(
              isConvergent: state.response.convergent,
              title: "Symbolic Sum",
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