import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/matrix/presentation/bloc/multiply_matrix/multiply_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/widgets/multiply_matrix/matrix_multiplication_initial_widget.dart';
import 'package:math_helper/features/matrix/presentation/widgets/multiply_matrix/matrix_multiplication_success_screen.dart';

class MatrixMultiplicationScreen extends StatelessWidget {
  final TextEditingController firstMatrixRowsController;
  final TextEditingController firstMatrixColumnsController;
  final TextEditingController secondMatrixRowsController;
  final TextEditingController secondMatrixColumnsController;
  final List<TextEditingController> firstMatrixControllers;
  final List<TextEditingController> secondMatrixControllers;
  const MatrixMultiplicationScreen({
    super.key,
    required this.firstMatrixRowsController,
    required this.firstMatrixColumnsController,
    required this.secondMatrixRowsController,
    required this.secondMatrixColumnsController,
    required this.firstMatrixControllers,
    required this.secondMatrixControllers,
    });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<MultiplyMatrixBloc, MultiplyMatrixState>(
        listener: (context, state) {
         if (state is MultiplyMatrixFailure) {
           showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is MultiplyMatrixInitial) {
            return MatrixMultiplicationInitialWidget(
              multiplicationFirstRowsController: firstMatrixRowsController,
              multiplicationFirstColumnsController: firstMatrixColumnsController,
              multiplicationSecondRowsController: secondMatrixRowsController,
              multiplicationSecondColumnsController: secondMatrixColumnsController,
              multiplicationFirstMatrixControllers: firstMatrixControllers,
              multiplicationSecondMatrixControllers: secondMatrixControllers,
            );
          } else if (state is MultiplyMatrixLoading) {
            return const LoadingScreen();
          } else if (state is MultiplyMatrixSuccess) {
            return MatrixMultiplicationSuccessScreen(
              matrixA: state.response.matrixA!,
              matrixB: state.response.matrixB!,
              resultMatrix: state.response.matrix!,
            
            );
          } else if (state is MultiplyMatrixFailure) {
            return MatrixMultiplicationInitialWidget(
              multiplicationFirstRowsController: firstMatrixRowsController,
              multiplicationFirstColumnsController: firstMatrixColumnsController,
              multiplicationSecondRowsController: secondMatrixRowsController,
              multiplicationSecondColumnsController: secondMatrixColumnsController,
              multiplicationFirstMatrixControllers: firstMatrixControllers,
              multiplicationSecondMatrixControllers: secondMatrixControllers,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

   void showToast(BuildContext context, String message) {
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.customRed,
      ),
    );
  }
}









