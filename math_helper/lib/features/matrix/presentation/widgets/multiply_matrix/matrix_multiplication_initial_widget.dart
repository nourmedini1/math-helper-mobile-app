import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/input_container.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/core/ui/components/clear_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/presentation/bloc/multiply_matrix/multiply_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/cubit/multiply_matrix/multiplication_first_matrix/multiplication_first_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/multiply_matrix/multiplication_first_matrix_fields/multiplication_first_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/multiply_matrix/multiplication_second_matrix/multiplication_second_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/multiply_matrix/multiplication_second_matrix_fields/multiplication_second_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/widgets/matrix_input_card.dart';
import 'package:math_helper/features/matrix/presentation/widgets/matrix_popup_widget.dart';
import 'package:provider/provider.dart';

enum MatrixType { first, second }

class MatrixMultiplicationInitialWidget extends StatelessWidget {
  final TextEditingController multiplicationFirstRowsController;
  final TextEditingController multiplicationFirstColumnsController;
  final TextEditingController multiplicationSecondRowsController;
  final TextEditingController multiplicationSecondColumnsController;
  final List<TextEditingController> multiplicationFirstMatrixControllers;
  final List<TextEditingController> multiplicationSecondMatrixControllers;

  const MatrixMultiplicationInitialWidget({
    super.key,
    required this.multiplicationFirstRowsController,
    required this.multiplicationFirstColumnsController,
    required this.multiplicationSecondRowsController,
    required this.multiplicationSecondColumnsController,
    required this.multiplicationFirstMatrixControllers,
    required this.multiplicationSecondMatrixControllers,
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
    required MatrixType matrixType,
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

        // Use parentContext here!
        if (matrixType == MatrixType.first) {
          parentContext.read<MultiplicationFirstMatrixFieldsCubit>().checkAllFieldsReady(allFilled);
          parentContext.read<MultiplicationFirstMatrixCubit>().checkStatus(isAnyFieldsFilled, rows, columns);
        } else {
          parentContext.read<MultiplicationSecondMatrixFieldsCubit>().checkAllFieldsReady(allFilled);
          parentContext.read<MultiplicationSecondMatrixCubit>().checkStatus(isAnyFieldsFilled, rows, columns);
        }
      },
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputContainer(
          title: "Matrix Multiplication",
          body: MatrixInputCard(
            label: "The first matrix",
            rowsController: multiplicationFirstRowsController,
            columnsController: multiplicationFirstColumnsController,
            actionButton: BlocBuilder<MultiplicationFirstMatrixCubit, MultiplicationFirstMatrixState>(
              builder: (context, state) {
                if (state is MultiplicationFirstMatrixInitial) {
                  return SubmitButton(
                    color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
                        ? AppColors.primaryColorTint50
                        : AppColors.primaryColor,
                    text: "Generate Matrix",
                    icon: Icons.add,
                    onPressed: () {
                      int rows = int.tryParse(multiplicationFirstRowsController.text) ?? 5;
                      int columns = int.tryParse(multiplicationFirstColumnsController.text) ?? 5;
                      rows = rows.clamp(1, 5);
                      columns = columns.clamp(1, 5);
                      multiplicationFirstMatrixControllers.clear();
                      for (int i = 0; i < rows * columns; i++) {
                        multiplicationFirstMatrixControllers.add(TextEditingController());
                      }
                      _showMatrixPopup(
                        context,
                        title: "Matrix Multiplication",
                        label: "First Matrix",
                        controllers: multiplicationFirstMatrixControllers,
                        rows: rows,
                        columns: columns,
                        onClear: () {
                          for (var controller in multiplicationFirstMatrixControllers) {
                            controller.clear();
                          }
                          context.read<MultiplicationFirstMatrixFieldsCubit>().reset();
                          context.read<MultiplicationFirstMatrixCubit>().reset();
                        },
                        matrixType: MatrixType.first,
                      );
                    },
                  );
                } else if (state is MultiplicationFirstMatrixGenerated) {
                  return SubmitButton(
                    color: AppColors.secondaryColor,
                    text: "Check Matrix",
                    icon: Icons.search,
                    onPressed: () {
                      _showMatrixPopup(
                        context,
                        title: "Matrix Multiplication",
                        label: "First Matrix",
                        controllers: multiplicationFirstMatrixControllers,
                        rows: state.rows,
                        columns: state.columns,
                        onClear: () {
                          for (var controller in multiplicationFirstMatrixControllers) {
                            controller.clear();
                          }
                          context.read<MultiplicationFirstMatrixFieldsCubit>().reset();
                          context.read<MultiplicationFirstMatrixCubit>().reset();
                        },
                        matrixType: MatrixType.first,
                      );
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
        InputContainer(
          body: MatrixInputCard(
            label: "The second matrix",
            rowsController: multiplicationSecondRowsController,
            columnsController: multiplicationSecondColumnsController,
            actionButton: BlocBuilder<MultiplicationSecondMatrixCubit, MultiplicationSecondMatrixState>(
              builder: (context, state) {
                if (state is MultiplicationSecondMatrixInitial) {
                  return SubmitButton(
                    color : Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
                        ? AppColors.primaryColorTint50
                        : AppColors.primaryColor,
                    text: "Generate Matrix",
                    icon: Icons.add,
                    onPressed: () {
                      int rows = int.tryParse(multiplicationSecondRowsController.text) ?? 5;
                      int columns = int.tryParse(multiplicationSecondColumnsController.text) ?? 5;
                      rows = rows.clamp(1, 5);
                      columns = columns.clamp(1, 5);
                      multiplicationSecondMatrixControllers.clear();
                      for (int i = 0; i < rows * columns; i++) {
                        multiplicationSecondMatrixControllers.add(TextEditingController());
                      }
                      _showMatrixPopup(
                        context,
                        title: "Matrix Multiplication",
                        label: "Second Matrix",
                        controllers: multiplicationSecondMatrixControllers,
                        rows: rows,
                        columns: columns,
                        onClear: () {
                          for (var controller in multiplicationSecondMatrixControllers) {
                            controller.clear();
                          }
                          context.read<MultiplicationSecondMatrixFieldsCubit>().reset();
                          context.read<MultiplicationSecondMatrixCubit>().reset();
                        },
                        matrixType: MatrixType.second,
                      );
                    },
                  );
                } else if (state is MultiplicationSecondMatrixGenerated) {
                  return SubmitButton(
                    color: AppColors.secondaryColor,
                    text: "Check Matrix",
                    icon: Icons.search,
                    onPressed: () {
                      _showMatrixPopup(
                        context,
                        title: "Matrix Multiplication",
                        label: "Second Matrix",
                        controllers: multiplicationSecondMatrixControllers,
                        rows: state.rows,
                        columns: state.columns,
                        onClear: () {
                          for (var controller in multiplicationSecondMatrixControllers) {
                            controller.clear();
                          }
                          context.read<MultiplicationSecondMatrixFieldsCubit>().reset();
                          context.read<MultiplicationSecondMatrixCubit>().reset();
                        },
                        matrixType: MatrixType.second,
                      );
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
         submitButton: BlocBuilder<MultiplicationFirstMatrixFieldsCubit, MultiplicationFirstMatrixFieldsState>(
  builder: (context, firstState) {
    return BlocBuilder<MultiplicationSecondMatrixFieldsCubit, MultiplicationSecondMatrixFieldsState>(
      builder: (context, secondState) {
        final isReady = context.read<MultiplicationFirstMatrixFieldsCubit>().isFieldsReady() &&
                        context.read<MultiplicationSecondMatrixFieldsCubit>().isFieldsReady();
        final theme = Provider.of<ThemeManager>(context, listen: false).themeData;
        return SubmitButton(
          color: isReady
              ? (theme == AppThemeData.lightTheme
                  ? AppColors.primaryColorTint50
                  : AppColors.primaryColor)
              : AppColors.customBlackTint80,
          onPressed: isReady
              ? () => handleSubmitButtonPressed(context)
              : () {},
        );
      },
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
    multiplicationFirstRowsController.clear();
    multiplicationFirstColumnsController.clear();
    multiplicationSecondRowsController.clear();
    multiplicationSecondColumnsController.clear();
    for (var controller in multiplicationFirstMatrixControllers) {
      controller.clear();
    }
    for (var controller in multiplicationSecondMatrixControllers) {
      controller.clear();
    }
    context.read<MultiplicationFirstMatrixFieldsCubit>().reset();
    context.read<MultiplicationSecondMatrixFieldsCubit>().reset();
    context.read<MultiplicationFirstMatrixCubit>().reset();
    context.read<MultiplicationSecondMatrixCubit>().reset();
  }

  void handleSubmitButtonPressed(BuildContext context) {
    int rowsA = int.tryParse(multiplicationFirstRowsController.text) ?? 5;
    int columnsA = int.tryParse(multiplicationFirstColumnsController.text) ?? 5;
    int rowsB = int.tryParse(multiplicationSecondRowsController.text) ?? 5;
    int columnsB = int.tryParse(multiplicationSecondColumnsController.text) ?? 5;

    if (columnsA != rowsB) {
      showToast(context, "The columns in the first matrix must equal the rows in the second matrix.");
      return;
    }

    List<double> flatA = multiplicationFirstMatrixControllers
        .map((controller) => double.tryParse(controller.text) ?? 0.0)
        .toList();
    List<List<double>> matrixA = List.generate(
      rowsA,
      (i) => flatA.sublist(i * columnsA, (i + 1) * columnsA),
    );
    List<double> flatB = multiplicationSecondMatrixControllers
        .map((controller) => double.tryParse(controller.text) ?? 0.0)
        .toList();
    List<List<double>> matrixB = List.generate(
      rowsB,
      (i) => flatB.sublist(i * columnsB, (i + 1) * columnsB),
    );

    MatrixRequest request = MatrixRequest(
      matrixA: matrixA,
      matrixB: matrixB,
    );
    BlocProvider.of<MultiplyMatrixBloc>(context).add(MultiplyMatrixRequested(
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