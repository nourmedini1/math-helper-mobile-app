import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/graph/graph_cubit.dart';

class PlotResetTile extends StatelessWidget {
  final bool isLight;
  final bool isFirstPlot;
  final TextEditingController functionController;

  const PlotResetTile({
    super.key,
    required this.isLight,
    required this.isFirstPlot,
    required this.functionController,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isLight
          ? AppColors.customBlackTint80.withOpacity(0.2)
          : AppColors.customBlackTint20,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      title: SizedBox(
        width: double.infinity,
        child: ResetButton(
          color: AppColors.primaryColorShade30,
          text: isFirstPlot ? "Reset to default" : "Reset to default",
          onPressed: () {
            if (isFirstPlot) {
              context.read<GraphCubit>().resetFirstGraph();
            } else {
              context.read<GraphCubit>().resetSecondGraph();
            }
          },
        )
      ),
    );
  }
}
