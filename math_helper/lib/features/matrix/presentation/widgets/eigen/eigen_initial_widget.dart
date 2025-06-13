import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/input_container.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/core/ui/components/clear_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/presentation/bloc/eigen/eigen_bloc.dart';
import 'package:math_helper/features/matrix/presentation/cubit/eigen/eigen_matrix/eigen_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/eigen/eigen_matrix_fields/eigen_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/widgets/matrix_input_card.dart';
import 'package:math_helper/features/matrix/presentation/widgets/matrix_popup_widget.dart';
import 'package:provider/provider.dart';


class EigenInitialWidget extends StatelessWidget {
  final TextEditingController rowsController;
  final TextEditingController columnsController;
  final List<TextEditingController> matrixControllers;

  const EigenInitialWidget({
    super.key,
    required this.rowsController,
    required this.columnsController,
    required this.matrixControllers,
   
  });

  void _showMatrixPopup(
    BuildContext parentContext, // <-- this is the context with providers!
    {
    required String title,
    required String label,
    required List<TextEditingController> controllers,
    required int rows,
    required int columns,
    required VoidCallback onClear,
  }
) {
  showDialog(
    context: parentContext,
    builder: (dialogContext) => MatrixPopup(
      title: title,
      label: label,
      controllers: controllers,
      rows: rows,
      columns: columns,
      onConfirm: () => Navigator.of(dialogContext).pop(),
      onClear: onClear,
      onChanged: (value) {
        bool allFilled = controllers.every((controller) => controller.text.isNotEmpty);
        bool isAnyFieldsFilled = controllers.any((controller) => controller.text.isNotEmpty);
        parentContext.read<EigenMatrixFieldsCubit>().checkAllFieldsReady(allFilled);
        parentContext.read<EigenMatrixCubit>().checkStatus(isAnyFieldsFilled, rows, columns);   
      },
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputContainer(
          title: "Eigen Values & Vectors",
          body: MatrixInputCard(
            label: "The input matrix",
            rowsController: rowsController,
            columnsController: columnsController,
            actionButton: BlocBuilder<EigenMatrixCubit, EigenMatrixState>(
              builder: (context, state) {
                if (state is EigenMatrixInitial) {
                  return SubmitButton(
                    color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
                        ? AppColors.primaryColorTint50
                        : AppColors.primaryColor,
                    text: "Generate Matrix",
                    icon: Icons.add,
                    onPressed: () {
                      int rows = int.tryParse(rowsController.text) ?? 5;
                      int columns = int.tryParse(columnsController.text) ?? 5;
                      rows = rows.clamp(1, 5);
                      columns = columns.clamp(1, 5);
                      matrixControllers.clear();
                      for (int i = 0; i < rows * columns; i++) {
                        matrixControllers.add(TextEditingController());
                      }
                      _showMatrixPopup(
                        context,
                        title: "Eigen Values & Vectors",
                        label: "Input Matrix",
                        controllers: matrixControllers,
                        rows: rows,
                        columns: columns,
                        onClear: () {
                          for (var controller in matrixControllers) {
                            controller.clear();
                          }
                          context.read<EigenMatrixFieldsCubit>().reset();
                          context.read<EigenMatrixCubit>().reset();
                        },
                      );
                    },
                  );
                } else if (state is EigenMatrixGenerated) {
                  return SubmitButton(
                    color: AppColors.secondaryColor,
                    text: "Check Matrix",
                    icon: Icons.search,
                    onPressed: () {
                      _showMatrixPopup(
                        context,
                        title: "Eigen Values & Vectors",
                        label: "Input Matrix",
                        controllers: matrixControllers,
                        rows: state.rows,
                        columns: state.columns,
                        onClear: () {
                          for (var controller in matrixControllers) {
                            controller.clear();
                          }
                          context.read<EigenMatrixFieldsCubit>().reset();
                          context.read<EigenMatrixCubit>().reset();
                        },
                      );
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          submitButton: BlocBuilder<EigenMatrixFieldsCubit, EigenMatrixFieldsState>(
  builder: (context, state) {
    return  SubmitButton(
          color: state is EigenMatrixFieldsReady
              ? Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
              ? AppColors.primaryColorTint50
              : AppColors.primaryColor
              : AppColors.customBlackTint80,
          onPressed: state is EigenMatrixFieldsReady
              ? () => handleSubmitButtonPressed(context)
              : () {},
        );
  },
),
          clearButton: ClearButton(
            text: "Clear All",
            onPressed: () {
              handleClearButtonPressed(context);
            },
          ),
        ),
        
      ],
    );
  }

  void handleClearButtonPressed(BuildContext context) {
    rowsController.clear();
    columnsController.clear();
    for (var controller in matrixControllers) {
      controller.clear();
    }
    context.read<EigenMatrixFieldsCubit>().reset();
    context.read<EigenMatrixCubit>().reset();
  }

  void handleSubmitButtonPressed(BuildContext context) {
    int rows= int.tryParse(rowsController.text) ?? 5;
    int columns = int.tryParse(columnsController.text) ?? 5;
   
    List<double> flat = matrixControllers
        .map((controller) => double.tryParse(controller.text) ?? 0.0)
        .toList();
    List<List<double>> matrix = List.generate(
      rows,
      (i) => flat.sublist(i * columns, (i + 1) * columns),
    );
    

    MatrixRequest request = MatrixRequest(
      matrixA: matrix  ,
      matrixB: null,
    );
    BlocProvider.of<EigenBloc>(context).add(EigenRequested(
      request: request,
    ));
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