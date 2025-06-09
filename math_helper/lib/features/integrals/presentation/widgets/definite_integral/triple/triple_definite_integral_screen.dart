import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_integral/triple_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/widgets/definite_integral/triple/triple_definite_integral_initial_screen.dart';
import 'package:math_helper/features/integrals/presentation/widgets/integral_success_screen.dart';

class TripleDefiniteIntegralScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> limitsControllers;
  final TextEditingController variableController;
  const TripleDefiniteIntegralScreen({
    super.key,
    required this.expressionController,
    required this.limitsControllers,
    required this.variableController,
  });

  @override
  State<TripleDefiniteIntegralScreen> createState() => _TripleDefiniteIntegralScreenState();
}

class _TripleDefiniteIntegralScreenState extends State<TripleDefiniteIntegralScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<TripleIntegralBloc, TripleIntegralState>(
        listener: (context, state) {
          if (state is TripleIntegralFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is TripleIntegralInitial) {
            return TripleDefiniteIntegralInitialScreen(
              expressionController: widget.expressionController,
              limitsControllers: widget.limitsControllers,
              variableController: widget.variableController,
            );
          } else if (state is TripleIntegralLoading) {
            return const LoadingScreen();
          } else if (state is TripleIntegralSuccess) {
            return IntegralSuccessScreen(
              title: "Triple Integral",
              integral: state.response.integral,
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