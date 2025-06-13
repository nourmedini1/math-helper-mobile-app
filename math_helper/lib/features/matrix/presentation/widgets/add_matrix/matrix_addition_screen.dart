import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/matrix/presentation/bloc/add_matrix/add_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/widgets/add_matrix/matrix_addition_initial_widget.dart';
import 'package:math_helper/features/matrix/presentation/widgets/add_matrix/matrix_addition_success_screen.dart';

class MatrixAdditionScreen extends StatelessWidget {
  final TextEditingController firstMatrixRowsController;
  final TextEditingController firstMatrixColumnsController;
  final TextEditingController secondMatrixRowsController;
  final TextEditingController secondMatrixColumnsController;
  final List<TextEditingController> firstMatrixControllers;
  final List<TextEditingController> secondMatrixControllers;
  const MatrixAdditionScreen({
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
      child: BlocConsumer<AddMatrixBloc, AddMatrixState>(
        listener: (context, state) {
         if (state is AddMatrixFailure) {
           showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AddMatrixInitial) {
            return MatrixAdditionInitialWidget(
              additionFirstRowsController: firstMatrixRowsController,
              additionFirstColumnsController: firstMatrixColumnsController,
              additionSecondRowsController: secondMatrixRowsController,
              additionSecondColumnsController: secondMatrixColumnsController,
              additionFirstMatrixControllers: firstMatrixControllers,
              additionSecondMatrixControllers: secondMatrixControllers,
            );
          } else if (state is AddMatrixLoading) {
            return const LoadingScreen();
          } else if (state is AddMatrixSuccess) {
            return MatrixAdditionSuccessScreen(
              matrixA: state.response.matrixA!,
              matrixB: state.response.matrixB!,
              resultMatrix: state.response.matrix!,
            
            );
          } else if (state is AddMatrixFailure) {
            return MatrixAdditionInitialWidget(
              additionFirstRowsController: firstMatrixRowsController,
              additionFirstColumnsController: firstMatrixColumnsController,
              additionSecondRowsController: secondMatrixRowsController,
              additionSecondColumnsController: secondMatrixColumnsController,
              additionFirstMatrixControllers: firstMatrixControllers,
              additionSecondMatrixControllers: secondMatrixControllers,
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