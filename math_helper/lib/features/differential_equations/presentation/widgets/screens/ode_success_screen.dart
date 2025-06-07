import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/differential_equations/presentation/bloc/first_order_differential_equation/first_order_differential_equation_bloc.dart';
import 'package:math_helper/features/differential_equations/presentation/widgets/ode_success_widget.dart';
import 'package:provider/provider.dart';

class OdeSuccessScreen extends StatelessWidget {
   final String title;
  final String expression;
  final String result;
  const OdeSuccessScreen({
    super.key,
    required this.title,
    required this.expression,
    required this.result,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      OdeSuccessWidget(
        title: title, 
        expression: expression, 
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
    BlocProvider.of<FirstOrderDifferentialEquationBloc>(context, listen: false).add(
      const FirstOrderDifferentialEquationReset(),
    );
  }
}