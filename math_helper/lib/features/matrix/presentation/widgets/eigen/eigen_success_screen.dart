import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/matrix/presentation/bloc/eigen/eigen_bloc.dart';
import 'package:math_helper/features/matrix/presentation/widgets/eigen/eigen_success_widget.dart';
import 'package:provider/provider.dart';

class EigenSuccessScreen extends StatelessWidget {
  final String value;
  final String vector;
  final String matrix;
  const EigenSuccessScreen({
    super.key,
    required this.value,
    required this.vector,
    required this.matrix,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      EigenSuccessWidget(
        title: "Eigen Values & Vectors", 
        value: value,
        vector: vector,
        matrix: matrix
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
        context.read<EigenBloc>().add(const EigenReset());
    }
  
}