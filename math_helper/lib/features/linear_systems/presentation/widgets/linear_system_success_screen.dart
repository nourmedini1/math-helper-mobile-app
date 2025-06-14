import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/linear_systems/presentation/bloc/solve_linear_system/solve_linear_system_bloc.dart';
import 'package:math_helper/features/linear_systems/presentation/widgets/linear_system_success_widget.dart';
import 'package:provider/provider.dart';

class LinearSystemSuccessScreen extends StatelessWidget {
  final String linearSystem;
  final String result;
  const LinearSystemSuccessScreen({
    super.key,
    required this.linearSystem,
    required this.result,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      LinearSystemSuccessWidget(
        title: "Linear System", 
        linearSystem: linearSystem,
        result: result
       ),
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
        context.read<SolveLinearSystemBloc>().add(const SolveLinearSystemReset());
    }
  
}