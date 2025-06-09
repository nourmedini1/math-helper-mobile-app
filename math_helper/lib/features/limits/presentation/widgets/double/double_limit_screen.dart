import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/limits/presentation/bloc/double_limit/double_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/widgets/double/double_limit_initial_widget.dart';
import 'package:math_helper/features/limits/presentation/widgets/limit_success_screen.dart';

class DoubleLimitScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> boundControllers;
  final List<TextEditingController> signControllers;
  final TextEditingController variableController;
  const DoubleLimitScreen({
    super.key,
    required this.expressionController,
    required this.variableController,
    required this.boundControllers,
    required this.signControllers,
  });

  @override
  State<DoubleLimitScreen> createState() => _DoubleLimitScreenState();
}

class _DoubleLimitScreenState extends State<DoubleLimitScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<DoubleLimitBloc, DoubleLimitState>(
        listener: (context, state) {
          if (state is DoubleLimitFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is DoubleLimitInitial) {
            return DoubleLimitInitialScreen(
              expressionController: widget.expressionController,
              signControllers: widget.signControllers,
              boundControllers: widget.boundControllers,
              variableController: widget.variableController,
            );
          } else if (state is DoubleLimitLoading) {
            return const LoadingScreen();
          } else if (state is DoubleLimitSuccess) {
            return LimitSuccessScreen(
              title: "Double Limit",
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