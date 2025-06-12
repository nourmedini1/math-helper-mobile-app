import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/components/custom_text_field.dart';
import 'package:math_helper/core/ui/components/textfield_label.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/first_graph_fields/first_graph_fields_cubit.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/second_graph_fields/second_graph_fields_cubit.dart';

class PlotExpressionTile extends StatelessWidget {
  final bool isLight;
  final TextEditingController controller;
  final bool isFirstPlot;

  const PlotExpressionTile({
    super.key,
    required this.isLight,
    required this.controller,
    required this.isFirstPlot,

  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: TextFieldLabel(label: "The expression"),
      ),
      subtitle: CustomTextField(
        hint: "Example : x^2 + 2x + 1",
        controller: controller,
        onChanged: (value) {
          if (isFirstPlot) {
           context.read<FirstGraphFieldsCubit>().checkAllFieldsReady(controller.text.isNotEmpty);
          } else {
            context.read<SecondGraphFieldsCubit>().checkAllFieldsReady(controller.text.isNotEmpty);
          }
        },
      ),
      tileColor: isLight
          ? AppColors.customBlackTint80.withOpacity(0.2)
          : AppColors.customBlackTint20,
    );
  }
}