import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_integral/double_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/double_primitive/double_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_integral/single_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/single_primitive/single_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_integral/triple_integral_bloc.dart';
import 'package:math_helper/features/integrals/presentation/bloc/triple_primitive/triple_primitive_bloc.dart';
import 'package:math_helper/features/integrals/presentation/widgets/integral_success_widget.dart';
import 'package:provider/provider.dart';

class IntegralSuccessScreen extends StatelessWidget {
   final String title;
  final String integral;
  final String result;
  const IntegralSuccessScreen({
    super.key,
    required this.title,
    required this.integral,
    required this.result,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      IntegralSuccessWidget(
        title: title, 
        integral: integral, 
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
      case "Single Integral":
        context.read<SingleIntegralBloc>().add(const SingleIntegralReset());
        break;
      case "Double Integral":
        context.read<DoubleIntegralBloc>().add(const DoubleIntegralReset());
        break;
      case "Triple Integral":
        context.read<TripleIntegralBloc>().add(const TripleIntegralReset());
        break;
      case "Single Primitive":
        context.read<SinglePrimitiveBloc>().add(const SinglePrimitiveReset());
        break;
      case "Double Primitive":
        context.read<DoublePrimitiveBloc>().add(const DoublePrimitiveReset());
        break;
      case "Triple Primitive":
        context.read<TriplePrimitiveBloc>().add(const TriplePrimitiveReset());
        break;
    }
  }
    
      
}