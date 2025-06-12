

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/components/custom_text_field.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/graph/graph_cubit.dart';

class AxisControls extends StatelessWidget {
  final TextEditingController xMinController;
  final TextEditingController xMaxController;
  final TextEditingController yMinController;
  final TextEditingController yMaxController;
  const AxisControls({
    super.key,
    required this.xMinController,
    required this.xMaxController,
    required this.yMinController,
    required this.yMaxController,

  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 18), // Add some space before the first column
          _axisColumn(
            context,
            "X Min:  ",
             xMinController,
              "", 
              (value) {
                double xMin = double.tryParse(value) ?? -10;
              context.read<GraphCubit>().updateFirstGraph(
                xMin: xMin.toString()
              );
            },
            "X Max: ",
           xMaxController,
           "",
            (value) {
              double xMax = double.tryParse(value) ?? 10;
              context.read<GraphCubit>().updateFirstGraph(
                xMax: xMax.toString()
              );
            },
          ),
          const SizedBox(width: 5), // Add some space between the two columns
          _axisColumn(
            context,
            "Y Min:  ",
            yMinController,
            "",
            (value) {
              double yMin = double.tryParse(value) ?? -10;
              context.read<GraphCubit>().updateFirstGraph(
                yMin: yMin.toString()
              );
            },
            "Y Max: ",
            yMaxController,
            "",
            (value) {
              double yMax = double.tryParse(value) ?? 10;
              context.read<GraphCubit>().updateFirstGraph(
                yMax: yMax.toString()
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _axisColumn(
    BuildContext context,
    String minLabel,
    TextEditingController minController,
    String minHint,
    ValueChanged<String> minOnChanged,
    String maxLabel,
    TextEditingController maxController,
    String maxHint,
    ValueChanged<String> maxOnChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFieldLabel(label: minLabel),
            SizedBox(
            width: 122,
             child: CustomTextField(
              hint: "", 
              controller: minController, 
              onChanged: minOnChanged
              ),
           )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFieldLabel(label: maxLabel),
            SizedBox(
              width: 122,
              child: CustomTextField(
                hint: "",
                controller: maxController,
                onChanged: maxOnChanged,
              ),
            )
          ],
        ),
      ],
    );
  }
}