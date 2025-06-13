import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/matrix/presentation/bloc/determinant/determinant_bloc.dart';
import 'package:math_helper/features/matrix/presentation/widgets/matrix_success_widget.dart';
import 'package:provider/provider.dart';

class DeterminantSuccessScreen extends StatelessWidget {
  final String matrix;
  final String resultMatrix;
  const DeterminantSuccessScreen({
    super.key,
    required this.matrix,
    required this.resultMatrix,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      MatrixSuccessWidget(
        title: "Determinant", 
        matrix: matrix,
        resultMatrix: resultMatrix
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
        context.read<DeterminantBloc>().add(const DeterminantReset());
    }
  
}