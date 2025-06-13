part of 'multiplication_first_matrix_cubit.dart';

@immutable
sealed class MultiplicationFirstMatrixState {}

final class MultiplicationFirstMatrixInitial extends MultiplicationFirstMatrixState {}
final class MultiplicationFirstMatrixGenerated extends MultiplicationFirstMatrixState {
  final int rows;
  final int columns;
  MultiplicationFirstMatrixGenerated({
    required this.rows,
    required this.columns,
  });


}
