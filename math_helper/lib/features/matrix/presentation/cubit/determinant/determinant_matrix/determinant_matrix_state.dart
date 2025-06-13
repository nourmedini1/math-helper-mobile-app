part of 'determinant_matrix_cubit.dart';

@immutable
sealed class DeterminantMatrixState {}

final class DeterminantMatrixInitial extends DeterminantMatrixState {}
final class DeterminantMatrixGenerated extends DeterminantMatrixState {
  final int rows;
  final int columns;
  DeterminantMatrixGenerated({
    required this.rows,
    required this.columns,
  });


}
