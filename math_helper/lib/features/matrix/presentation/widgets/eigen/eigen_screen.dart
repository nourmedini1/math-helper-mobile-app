import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/loading_screen.dart';
import 'package:math_helper/features/matrix/presentation/bloc/eigen/eigen_bloc.dart';
import 'package:math_helper/features/matrix/presentation/widgets/eigen/eigen_initial_widget.dart';
import 'package:math_helper/features/matrix/presentation/widgets/eigen/eigen_success_screen.dart';

class EigenScreen extends StatelessWidget {
  final TextEditingController rowsController;
  final TextEditingController columnsController;
  final List<TextEditingController> matrixControllers;
  const EigenScreen({
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
      child: BlocConsumer<EigenBloc, EigenState>(
        listener: (context, state) {
         if (state is EigenFailure) {
           showToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is EigenInitial) {
            return EigenInitialWidget(
              rowsController: rowsController,
              columnsController: columnsController,
              matrixControllers: matrixControllers,
            );
          } else if (state is EigenLoading) {
            return const LoadingScreen();
          } else if (state is EigenSuccess) {
            return EigenSuccessScreen(
              matrix: state.response.matrixA!,
              value: state.response.eigenValue!,
              vector: state.response.eigenVector!,
            );
          } else if (state is EigenFailure) {
            return EigenInitialWidget(
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

