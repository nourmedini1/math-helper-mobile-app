import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/matrix/presentation/bloc/invert_matrix/invert_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/widgets/invert_matrix/invert_matrix_initial_widget.dart';
import 'package:math_helper/features/matrix/presentation/widgets/invert_matrix/invert_matrix_success_screen.dart';

class InvertMatrixScreen extends StatelessWidget {
  final TextEditingController rowsController;
  final TextEditingController columnsController;
  final List<TextEditingController> matrixControllers;
  const InvertMatrixScreen({
    super.key,
    required this.rowsController,
    required this.columnsController,
    required this.matrixControllers,
    });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: BlocConsumer<InvertMatrixBloc, InvertMatrixState>(
        listener: (context, state) {
         if (state is InvertMatrixFailure) {
           showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is InvertMatrixInitial) {
            return InvertMatrixInitialWidget(
              rowsController: rowsController,
              columnsController: columnsController,
              matrixControllers: matrixControllers,
            );
          } else if (state is InvertMatrixLoading) {
            return const LoadingScreen();
          } else if (state is InvertMatrixSuccess) {
            return InvertMatrixSuccessScreen(
              matrix: state.response.matrixA!,
              resultMatrix: state.response.matrix!,
            
            );
          } else if (state is InvertMatrixFailure) {
            return InvertMatrixInitialWidget(
              rowsController: rowsController,
              columnsController: columnsController,
              matrixControllers: matrixControllers,      
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

