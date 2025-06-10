import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/sum/presentation/bloc/numeric_sum/numeric_sum_bloc.dart';
import 'package:math_helper/features/sum/presentation/bloc/symbolic_sum/symbolic_sum_bloc.dart';
import 'package:math_helper/features/sum/presentation/widgets/sum_success_widget.dart';
import 'package:provider/provider.dart';

class SumSuccessScreen extends StatelessWidget {
   final String title;
  final String sum;
  final String result;
  final bool isConvergent;
  const SumSuccessScreen({
    super.key,
    required this.title,
    required this.sum,
    required this.result,
    required this.isConvergent,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SumSuccessWidget(
        isConvergent: isConvergent,
        title: title, 
        expression: sum, 
        result: result),
      const SizedBox(height: 20),
      ResetButton(
        color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
            ? AppColors.primaryColorTint50
            : AppColors.primaryColor,
        onPressed: () => handleResetButtonPressed(context),
        ),
    ],

    );
  }

  void handleResetButtonPressed(BuildContext context) {
    switch (title) {
      case "Symbolic Sum":
        context.read<SymbolicSumBloc>().add(const SymbolicSumReset());
        break;
      case "Numeric Sum":
        context.read<NumericSumBloc>().add(const NumericSumReset());
        break;   
      default:
        throw Exception("Unknown sum type: $title");
    }
  }
    
      
}