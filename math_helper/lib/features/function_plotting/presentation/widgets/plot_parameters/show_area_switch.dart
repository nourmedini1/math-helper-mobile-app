import 'package:flutter/material.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/graph/graph_cubit.dart';
import 'package:provider/provider.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/graph_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PlotShowAreaSwitch extends StatelessWidget {
  final bool isLight;
  final bool isFirstPlot;
  final GraphData graphData;

  const PlotShowAreaSwitch({
    super.key,
    required this.isLight,
    required this.isFirstPlot,
    required this.graphData,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: TextFieldLabel(label: "Show Area"),
      ),
      value: graphData.showArea,
      onChanged: (value) {
        if (isFirstPlot) {
          context.read<GraphCubit>().updateFirstGraph(showArea: value);
        } else {
          context.read<GraphCubit>().updateSecondGraph(showArea: value);
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