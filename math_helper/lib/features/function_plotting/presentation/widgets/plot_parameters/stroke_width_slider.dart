import 'package:flutter/material.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/graph/graph_cubit.dart';
import 'package:provider/provider.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/graph_data.dart';
class PlotStrokeWidthSlider extends StatelessWidget {
  final bool isLight;
  final bool isFirstPlot;
  final GraphData graphData;

  const PlotStrokeWidthSlider({
    super.key,
    required this.isLight,
    required this.isFirstPlot,
    required this.graphData,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: TextFieldLabel(label: "Stroke Width"),
      ),
      subtitle: Slider(
        value: graphData.strokeWidth,
        min: 1.0,
        max: 10.0,
        divisions: 9,
        label: graphData.strokeWidth.toString(),
        onChanged: (value) {
          if (isFirstPlot) {
            context.read<GraphCubit>().updateFirstGraph(strokeWidth: value);
          } else {
            context.read<GraphCubit>().updateSecondGraph(strokeWidth: value);
          }
        },
        activeColor: Provider.of<ThemeManager>(context).themeData == AppThemeData.lightTheme
            ? AppColors.primaryColorTint50
            : AppColors.primaryColor,
        inactiveColor: AppColors.customWhite,
        thumbColor: Provider.of<ThemeManager>(context).themeData == AppThemeData.lightTheme
            ? AppColors.primaryColorTint50
            : AppColors.primaryColor,
      ),
      tileColor: isLight
          ? AppColors.customBlackTint80.withOpacity(0)
          : AppColors.customBlackTint20,
    );
  }
}