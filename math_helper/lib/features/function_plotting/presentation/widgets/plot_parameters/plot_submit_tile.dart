import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/plot_parameters/first_graph_submit_button.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/plot_parameters/second_graph_submit_button.dart';

class PlotSubmitTile extends StatelessWidget {
  final bool isLight;
  final bool isFirstPlot;
  final TextEditingController functionController;

  const PlotSubmitTile({
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
        child: isFirstPlot
            ? FirstGraphSubmitButton(functionController: functionController, isFirstPlot: isFirstPlot,)
            : SecondGraphSubmitButton(functionController: functionController, isFirstPlot: isFirstPlot,),
      ),
    );
  }
}
