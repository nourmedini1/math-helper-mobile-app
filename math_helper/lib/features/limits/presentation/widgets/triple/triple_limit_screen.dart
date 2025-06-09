import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/Limits/presentation/widgets/Limit_success_screen.dart';
import 'package:math_helper/features/limits/presentation/bloc/triple_limit/triple_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/widgets/triple/triple_limit_initial_widget.dart';

class TripleLimitScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> boundControllers;
  final List<TextEditingController> signControllers;
  final TextEditingController variableController;
  const TripleLimitScreen({
    super.key,
    required this.expressionController,
    required this.variableController,
    required this.boundControllers,
    required this.signControllers,
  });

  @override
  State<TripleLimitScreen> createState() => _TripleLimitScreenState();
}

class _TripleLimitScreenState extends State<TripleLimitScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<TripleLimitBloc, TripleLimitState>(
        listener: (context, state) {
          if (state is TripleLimitFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is TripleLimitInitial) {
            return TripleLimitInitialScreen(
              expressionController: widget.expressionController,
              signControllers: widget.signControllers,
              boundControllers: widget.boundControllers,
              variableController: widget.variableController,
            );
          } else if (state is TripleLimitLoading) {
            return const LoadingScreen();
          } else if (state is TripleLimitSuccess) {
            return LimitSuccessScreen(
              title: "Triple Limit",
              limit: state.response.limit,
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