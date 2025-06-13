import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/matrix/presentation/bloc/determinant/determinant_bloc.dart';
import 'package:math_helper/features/matrix/presentation/widgets/determinant/determinant_initial_widget.dart';
import 'package:math_helper/features/matrix/presentation/widgets/determinant/determinant_success_screen.dart';

class DeterminantScreen extends StatelessWidget {
  final TextEditingController rowsController;
  final TextEditingController columnsController;
  final List<TextEditingController> matrixControllers;
  const DeterminantScreen({
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
      child: BlocConsumer<DeterminantBloc, DeterminantState>(
        listener: (context, state) {
         if (state is DeterminantFailure) {
           showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is DeterminantInitial) {
            return DeterminantInitialWidget(
              rowsController: rowsController,
              columnsController: columnsController,
              matrixControllers: matrixControllers,
            );
          } else if (state is DeterminantLoading) {
            return const LoadingScreen();
          } else if (state is DeterminantSuccess) {
            return DeterminantSuccessScreen(
              matrix: state.response.matrixA!,
              resultMatrix: state.response.determinant!,
            
            );
          } else if (state is DeterminantFailure) {
            return DeterminantInitialWidget(
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

