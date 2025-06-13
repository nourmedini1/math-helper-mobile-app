import 'package:flutter/material.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/graph_data.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/plot_parameters/area_color_picker_tile.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/plot_parameters/color_picker_tile.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/plot_parameters/show_area_switch.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/plot_parameters/show_dots_switch.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/plot_parameters/show_plot_switch.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/plot_parameters/stroke_width_slider.dart';
import 'package:math_helper/core/ui/components/expandable_widget.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/app_colors.dart';

class PlotAppearanceTile extends StatelessWidget {
  final bool isLight;
  final bool isFirstPlot;
  final GraphData graphData;

  const PlotAppearanceTile({
    super.key,
    required this.isLight,
    required this.isFirstPlot,
    required this.graphData,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isLight
          ? AppColors.customBlackTint80.withOpacity(0.2)
          : AppColors.customBlackTint20,
      title: ExpandableGroup(
        isExpanded: false,
        headerBackgroundColor: isLight
            ? AppColors.customBlackTint80.withOpacity(0)
            : AppColors.customBlackTint20,
        header: const Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFieldLabel(label: "Plot Appearance"),
        ),
        items: [
          PlotShowPlotSwitch(isLight: isLight, isFirstPlot: isFirstPlot, graphData: graphData),
          PlotColorPickerTile(isLight: isLight, isFirstPlot: isFirstPlot, graphData: graphData,),
          PlotShowDotsSwitch(isLight: isLight, isFirstPlot: isFirstPlot, graphData: graphData),
          PlotStrokeWidthSlider(isLight: isLight, isFirstPlot: isFirstPlot, graphData: graphData),
          PlotShowAreaSwitch(isLight: isLight, isFirstPlot: isFirstPlot, graphData: graphData),
          PlotAreaColorPickerTile(isLight: isLight, isFirstPlot: isFirstPlot, graphData: graphData,),
        ],
      ),
    );
  }
}