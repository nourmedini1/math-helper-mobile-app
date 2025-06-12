import 'package:flutter/material.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/graph/graph_cubit.dart';
import 'package:provider/provider.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/graph_data.dart';


class PlotShowDotsSwitch extends StatelessWidget {
  final bool isLight;
  final bool isFirstPlot;
  final GraphData graphData;

  const PlotShowDotsSwitch({
    super.key,
    required this.isLight,
    required this.isFirstPlot,
    required this.graphData,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Padding(
        padding: EdgeInsets.only(top: 18, left: 8.0, right: 8.0, bottom: 8.0),
        child: TextFieldLabel(label: "Show Dots"),
      ),
      value: graphData.showDots,
      onChanged: (value) {
        if (isFirstPlot) {
          context.read<GraphCubit>().updateFirstGraph(showDots: value);
        } else {
          context.read<GraphCubit>().updateSecondGraph(showDots: value);
        }
      },
      activeColor: Provider.of<ThemeManager>(context).themeData == AppThemeData.lightTheme
          ? AppColors.primaryColorTint50
          : AppColors.primaryColor,
      tileColor: isLight
          ? AppColors.customBlackTint80.withOpacity(0)
          : AppColors.customBlackTint20,
    );
  }
}