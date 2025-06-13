import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/reset_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/matrix/presentation/bloc/add_matrix/add_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/widgets/matrix_operation_success_widget.dart';
import 'package:provider/provider.dart';

class MatrixAdditionSuccessScreen extends StatelessWidget {
  final String matrixA;
  final String matrixB;
  final String resultMatrix;
  const MatrixAdditionSuccessScreen({
    super.key,
    required this.matrixA,
    required this.matrixB,
    required this.resultMatrix,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      MatrixOperationSuccessWidget(
        title: "Matrix Addition", 
        matrixA: matrixA,
        matrixB: matrixB,
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
        context.read<AddMatrixBloc>().add(const AddMatrixReset());
    }
  
}