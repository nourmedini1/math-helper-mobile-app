import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/graph/graph_cubit.dart';
import 'package:math_helper/features/function_plotting/presentation/widgets/graph_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PlotAreaColorPickerTile extends StatelessWidget {
  final bool isLight;
  final bool isFirstPlot;
  final GraphData graphData;

  const PlotAreaColorPickerTile({
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
        child: TextFieldLabel(label: "Area Color"),
      ),
      subtitle: GestureDetector(
        onTap: () => _showAreaColorPickerDialog(context),
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: graphData.areaColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      tileColor: isLight
          ? AppColors.customBlackTint80.withOpacity(0)
          : AppColors.customBlackTint20,
    );
  }

  void _showAreaColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const TextFieldLabel(label: "Select the area color"),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: graphData.areaColor,
              onColorChanged: (color) {
                if (isFirstPlot) {
                  context.read<GraphCubit>().updateFirstGraph(areaColor: color.withOpacity(0.2));
                } else {
                  context.read<GraphCubit>().updateSecondGraph(areaColor: color.withOpacity(0.2));
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const TextFieldLabel(label: "Close"),
            ),
          ],
        );
      },
    );
  }
}