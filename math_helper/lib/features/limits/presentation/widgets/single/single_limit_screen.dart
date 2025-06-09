import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/limits/presentation/bloc/single_limit/single_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/widgets/limit_success_screen.dart';
import 'package:math_helper/features/limits/presentation/widgets/single/single_limit_initial_widget.dart';

class SingleLimitScreen extends StatefulWidget {
  final TextEditingController expressionController;
  final List<TextEditingController> boundControllers;
  final List<TextEditingController> signControllers;
  final TextEditingController variableController;
  const SingleLimitScreen({
    super.key,
    required this.expressionController,
    required this.variableController,
    required this.boundControllers,
    required this.signControllers,
  });

  @override
  State<SingleLimitScreen> createState() => _SingleLimitScreenState();
}

class _SingleLimitScreenState extends State<SingleLimitScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<SingleLimitBloc, SingleLimitState>(
        listener: (context, state) {
          if (state is SingleLimitFailure) {
            showToast(context, state.message);
         }
        },
        builder: (context, state) {
          if (state is SingleLimitInitial) {
            return SingleLimitInitialScreen(
              expressionController: widget.expressionController,
              signControllers: widget.signControllers,
              boundControllers: widget.boundControllers,
              variableController: widget.variableController,
            );
          } else if (state is SingleLimitLoading) {
            return const LoadingScreen();
          } else if (state is SingleLimitSuccess) {
            return LimitSuccessScreen(
              title: "Single Limit",
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