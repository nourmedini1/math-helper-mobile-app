part of 'addition_second_matrix_cubit.dart';

@immutable
sealed class AdditionSecondMatrixState {}

final class AdditionSecondMatrixInitial extends AdditionSecondMatrixState {}
final class AdditionSecondMatrixGenerated extends AdditionSecondMatrixState {

  final int rows;
  final int columns;
  AdditionSecondMatrixGenerated({
    required this.rows,
    required this.columns,
  });
}
