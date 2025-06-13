part of 'invert_matrix_cubit.dart';

@immutable
sealed class InvertMatrixState {}

final class InvertMatrixInitial extends InvertMatrixState {}
final class InvertMatrixGenerated extends InvertMatrixState {
  final int rows;
  final int columns;
  InvertMatrixGenerated({
    required this.rows,
    required this.columns,
  });
}
