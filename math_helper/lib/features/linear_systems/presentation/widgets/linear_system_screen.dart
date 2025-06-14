import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/linear_systems/presentation/bloc/solve_linear_system/solve_linear_system_bloc.dart';
import 'package:math_helper/features/linear_systems/presentation/widgets/linear_system_initial_widget.dart';
import 'package:math_helper/features/linear_systems/presentation/widgets/linear_system_success_screen.dart';


class LinearSystemScreen extends StatelessWidget {
  final TextEditingController nbEquationsController;
  final TextEditingController variablesController;
  final List<TextEditingController> equationsControllers;
  final List<TextEditingController> rightHandSideControllers;
  const LinearSystemScreen({
    super.key,
    required this.nbEquationsController,
    required this.variablesController,
    required this.equationsControllers,
    required this.rightHandSideControllers,
    });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<SolveLinearSystemBloc, SolveLinearSystemState>(
        listener: (context, state) {
         if (state is SolveLinearSystemFailure) {
           showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is SolveLinearSystemInitial) {
            return LinearSystemInitialWidget(
              nbEquationsController: nbEquationsController,
              variablesController: variablesController,
              equationsControllers: equationsControllers,
              rightHandSideControllers: rightHandSideControllers,
            );
          } else if (state is SolveLinearSystemLoading) {
            return const LoadingScreen();
          } else if (state is SolveLinearSystemSuccess) {
            return LinearSystemSuccessScreen(
              linearSystem: state.response.linearSystem,
              result: state.response.result!,
            
            );
          } else if (state is SolveLinearSystemFailure) {
            return LinearSystemInitialWidget(
              nbEquationsController: nbEquationsController,
              variablesController: variablesController,
              equationsControllers: equationsControllers,
              rightHandSideControllers: rightHandSideControllers,
            );
          }
          return const SizedBox.shrink();
        },
      ),
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

