import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/taylor_series/presentation/bloc/expand_taylor_series/expand_taylor_series_bloc.dart';
import 'package:math_helper/features/taylor_series/presentation/widgets/taylor_series_success_widget.dart';
import 'package:provider/provider.dart';

class TaylorSeriesSuccessScreen extends StatelessWidget {
  final String title;
  final String expression;
  final String result;
  const TaylorSeriesSuccessScreen({super.key, required this.title, required this.expression, required this.result});

  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      TaylorSeriesSuccessWidget(
        title: title,
        expression: expression,
        result: result, 
        ),
        const SizedBox(height: 20),
      ResetButton(
        color : Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
            ? AppColors.primaryColorTint50
            : AppColors.primaryColor,
        onPressed: () => handleResetButtonPressed(context),
        ),
    ]

  );
  }

  void handleResetButtonPressed(BuildContext context) {
    BlocProvider.of<ExpandTaylorSeriesBloc>(context, listen: false)
        .add(const ExpandTaylorSeriesReset());
  }
}