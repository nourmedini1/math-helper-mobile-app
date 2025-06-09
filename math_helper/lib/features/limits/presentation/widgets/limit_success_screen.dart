import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/limits/presentation/bloc/double_limit/double_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/bloc/single_limit/single_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/bloc/triple_limit/triple_limit_bloc.dart';
import 'package:math_helper/features/limits/presentation/widgets/limit_success_widget.dart';
import 'package:provider/provider.dart';

class LimitSuccessScreen extends StatelessWidget {
   final String title;
  final String limit;
  final String result;
  const LimitSuccessScreen({
    super.key,
    required this.title,
    required this.limit,
    required this.result,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      LimitSuccessWidget(
        title: title, 
        limit: limit, 
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
      case "Single Limit":
        context.read<SingleLimitBloc>().add(const SingleLimitReset());
        break;
      case "Double Limit":
        context.read<DoubleLimitBloc>().add(const DoubleLimitReset());
        break;
      case "Triple Limit":
        context.read<TripleLimitBloc>().add(const TripleLimitReset());
        break;
      default:
        throw Exception("Unknown limit type: $title");
    }
  }
    
      
}