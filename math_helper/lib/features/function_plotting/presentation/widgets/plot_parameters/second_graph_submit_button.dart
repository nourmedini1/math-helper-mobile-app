import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_request.dart';
import 'package:math_helper/features/function_plotting/presentation/bloc/function_plotting_bloc.dart';
import 'package:math_helper/features/function_plotting/presentation/cubit/second_graph_fields/second_graph_fields_cubit.dart';
import 'package:provider/provider.dart';

class SecondGraphSubmitButton extends StatelessWidget {
  final TextEditingController functionController;
  final bool isFirstPlot;

  const SecondGraphSubmitButton({super.key, required this.functionController, required this.isFirstPlot});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondGraphFieldsCubit, SecondGraphFieldsState>(
      builder: (context, state) {
        final theme = Provider.of<ThemeManager>(context).themeData;
        final color = theme == AppThemeData.lightTheme
            ? AppColors.primaryColorTint50
            : AppColors.primaryColor;
        if (state is SecondGraphFieldsReady) {
          return SubmitButton(
            onPressed: () => _handleSubmit(context),
            text: "Plot Graph",
            icon: Icons.check,
            color: color,
          );
        } else {
          return SubmitButton(
            onPressed: () {},
            text: "Plot Graph",
            icon: Icons.check,
            color: AppColors.customBlackTint80,
          );
        }
      },
    );
  }

  void _handleSubmit(BuildContext context) {
   final functionText = functionController.text.trim();
            if (functionText.isEmpty) return;
            final plotRequest = PlotRequest(
              function: functionText,
              precision: _isPeriodic(functionText) ? 5000 : 1500,
              lowerBound: -1000,
              upperBound: 1000,
              maxPoints: 1000,
              isFirstPlot: isFirstPlot,
            );

            context.read<FunctionPlottingBloc>().add(
              PlotFunctionRequested(request: plotRequest),
            );
  }

  bool _isPeriodic(String function) {
    return function.contains('sin') || function.contains('cos');
  }
}