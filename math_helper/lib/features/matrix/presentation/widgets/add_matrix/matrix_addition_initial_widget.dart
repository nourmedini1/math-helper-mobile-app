import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/components/input_container.dart';
import 'package:math_helper/core/ui/components/submit_button.dart';
import 'package:math_helper/core/ui/components/clear_button.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/presentation/bloc/add_matrix/add_matrix_bloc.dart';
import 'package:math_helper/features/matrix/presentation/cubit/add_matrix/addition_first_matrix/addition_first_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/add_matrix/addition_first_matrix_fields/addition_first_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/add_matrix/addition_second_matrix/addition_second_matrix_cubit.dart';
import 'package:math_helper/features/matrix/presentation/cubit/add_matrix/addition_second_matrix_fields/addition_second_matrix_fields_cubit.dart';
import 'package:math_helper/features/matrix/presentation/widgets/matrix_input_card.dart';
import 'package:math_helper/features/matrix/presentation/widgets/matrix_popup_widget.dart';
import 'package:provider/provider.dart';

enum MatrixType { first, second }

class MatrixAdditionInitialWidget extends StatelessWidget {
  final TextEditingController additionFirstRowsController;
  final TextEditingController additionFirstColumnsController;
  final TextEditingController additionSecondRowsController;
  final TextEditingController additionSecondColumnsController;
  final List<TextEditingController> additionFirstMatrixControllers;
  final List<TextEditingController> additionSecondMatrixControllers;

  const MatrixAdditionInitialWidget({
    super.key,
    required this.additionFirstRowsController,
    required this.additionFirstColumnsController,
    required this.additionSecondRowsController,
    required this.additionSecondColumnsController,
    required this.additionFirstMatrixControllers,
    required this.additionSecondMatrixControllers,
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
          parentContext.read<AdditionFirstMatrixFieldsCubit>().checkAllFieldsReady(allFilled);
          parentContext.read<AdditionFirstMatrixCubit>().checkStatus(isAnyFieldsFilled, rows, columns);
        } else {
          parentContext.read<AdditionSecondMatrixFieldsCubit>().checkAllFieldsReady(allFilled);
          parentContext.read<AdditionSecondMatrixCubit>().checkStatus(isAnyFieldsFilled, rows, columns);
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
          title: "Matrix Addition",
          body: MatrixInputCard(
            label: "The first matrix",
            rowsController: additionFirstRowsController,
            columnsController: additionFirstColumnsController,
            actionButton: BlocBuilder<AdditionFirstMatrixCubit, AdditionFirstMatrixState>(
              builder: (context, state) {
                if (state is AdditionFirstMatrixInitial) {
                  return SubmitButton(
                    color: Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
                        ? AppColors.primaryColorTint50
                        : AppColors.primaryColor,
                    text: "Generate Matrix",
                    icon: Icons.add,
                    onPressed: () {
                      int rows = int.tryParse(additionFirstRowsController.text) ?? 5;
                      int columns = int.tryParse(additionFirstColumnsController.text) ?? 5;
                      additionFirstMatrixControllers.clear();
                      for (int i = 0; i < rows * columns; i++) {
                        additionFirstMatrixControllers.add(TextEditingController());
                      }
                      _showMatrixPopup(
                        context,
                        title: "Matrix Addition",
                        label: "First Matrix",
                        controllers: additionFirstMatrixControllers,
                        rows: rows,
                        columns: columns,
                        onClear: () {
                          for (var controller in additionFirstMatrixControllers) {
                            controller.clear();
                          }
                          context.read<AdditionFirstMatrixFieldsCubit>().reset();
                          context.read<AdditionFirstMatrixCubit>().reset();
                        },
                        matrixType: MatrixType.first,
                      );
                    },
                  );
                } else if (state is AdditionFirstMatrixGenerated) {
                  return SubmitButton(
                    color: AppColors.secondaryColor,
                    text: "Check Matrix",
                    icon: Icons.search,
                    onPressed: () {
                      _showMatrixPopup(
                        context,
                        title: "Matrix Addition",
                        label: "First Matrix",
                        controllers: additionFirstMatrixControllers,
                        rows: state.rows,
                        columns: state.columns,
                        onClear: () {
                          for (var controller in additionFirstMatrixControllers) {
                            controller.clear();
                          }
                          context.read<AdditionFirstMatrixFieldsCubit>().reset();
                          context.read<AdditionFirstMatrixCubit>().reset();
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
            rowsController: additionSecondRowsController,
            columnsController: additionSecondColumnsController,
            actionButton: BlocBuilder<AdditionSecondMatrixCubit, AdditionSecondMatrixState>(
              builder: (context, state) {
                if (state is AdditionSecondMatrixInitial) {
                  return SubmitButton(
                    color : Provider.of<ThemeManager>(context, listen: false).themeData == AppThemeData.lightTheme
                        ? AppColors.primaryColorTint50
                        : AppColors.primaryColor,
                    text: "Generate Matrix",
                    icon: Icons.add,
                    onPressed: () {
                      int rows = int.tryParse(additionSecondRowsController.text) ?? 5;
                      int columns = int.tryParse(additionSecondColumnsController.text) ?? 5;
                      additionSecondMatrixControllers.clear();
                      for (int i = 0; i < rows * columns; i++) {
                        additionSecondMatrixControllers.add(TextEditingController());
                      }
                      _showMatrixPopup(
                        context,
                        title: "Matrix Addition",
                        label: "Second Matrix",
                        controllers: additionSecondMatrixControllers,
                        rows: rows,
                        columns: columns,
                        onClear: () {
                          for (var controller in additionSecondMatrixControllers) {
                            controller.clear();
                          }
                          context.read<AdditionSecondMatrixFieldsCubit>().reset();
                          context.read<AdditionSecondMatrixCubit>().reset();
                        },
                        matrixType: MatrixType.second,
                      );
                    },
                  );
                } else if (state is AdditionSecondMatrixGenerated) {
                  return SubmitButton(
                    color: AppColors.secondaryColor,
                    text: "Check Matrix",
                    icon: Icons.search,
                    onPressed: () {
                      _showMatrixPopup(
                        context,
                        title: "Matrix Addition",
                        label: "Second Matrix",
                        controllers: additionSecondMatrixControllers,
                        rows: state.rows,
                        columns: state.columns,
                        onClear: () {
                          for (var controller in additionSecondMatrixControllers) {
                            controller.clear();
                          }
                          context.read<AdditionSecondMatrixFieldsCubit>().reset();
                          context.read<AdditionSecondMatrixCubit>().reset();
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
         submitButton: BlocBuilder<AdditionFirstMatrixFieldsCubit, AdditionFirstMatrixFieldsState>(
  builder: (context, firstState) {
    return BlocBuilder<AdditionSecondMatrixFieldsCubit, AdditionSecondMatrixFieldsState>(
      builder: (context, secondState) {
        final isReady = context.read<AdditionFirstMatrixFieldsCubit>().isFieldsReady() &&
                        context.read<AdditionSecondMatrixFieldsCubit>().isFieldsReady();
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
    additionFirstRowsController.clear();
    additionFirstColumnsController.clear();
    additionSecondRowsController.clear();
    additionSecondColumnsController.clear();
    for (var controller in additionFirstMatrixControllers) {
      controller.clear();
    }
    for (var controller in additionSecondMatrixControllers) {
      controller.clear();
    }
    context.read<AdditionFirstMatrixFieldsCubit>().reset();
    context.read<AdditionSecondMatrixFieldsCubit>().reset();
    context.read<AdditionFirstMatrixCubit>().reset();
    context.read<AdditionSecondMatrixCubit>().reset();
  }

  void handleSubmitButtonPressed(BuildContext context) {

    int rowsA = int.tryParse(additionFirstRowsController.text) ?? 5;
    int columnsA = int.tryParse(additionFirstColumnsController.text) ?? 5;
    int rowsB = int.tryParse(additionSecondRowsController.text) ?? 5;
    int columnsB = int.tryParse(additionSecondColumnsController.text) ?? 5;


    if (rowsA != rowsB || columnsA != columnsB) {
      showToast(context, "Matrices must have the same dimensions for addition.");
      return;
    }

    List<double> flatA = additionFirstMatrixControllers
        .map((controller) => double.tryParse(controller.text) ?? 0.0)
        .toList();
    List<List<double>> matrixA = List.generate(
      rowsA,
      (i) => flatA.sublist(i * columnsA, (i + 1) * columnsA),
    );
    List<double> flatB = additionSecondMatrixControllers
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
    BlocProvider.of<AddMatrixBloc>(context).add(AddMatrixRequested(
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