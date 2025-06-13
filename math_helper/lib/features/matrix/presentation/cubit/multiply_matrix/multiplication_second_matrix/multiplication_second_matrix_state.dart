part of 'multiplication_second_matrix_cubit.dart';

@immutable
sealed class MultiplicationSecondMatrixState {}

final class MultiplicationSecondMatrixInitial extends MultiplicationSecondMatrixState {}
final class MultiplicationSecondMatrixGenerated extends MultiplicationSecondMatrixState {

  final int rows;
  final int columns;
  MultiplicationSecondMatrixGenerated({
    required this.rows,
    required this.columns,
  });


}