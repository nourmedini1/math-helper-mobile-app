part of 'eigen_matrix_cubit.dart';

@immutable
sealed class EigenMatrixState {}

final class EigenMatrixInitial extends EigenMatrixState {}
final class EigenMatrixGenerated extends EigenMatrixState {
  final int rows;
  final int columns;
  EigenMatrixGenerated({
    required this.rows,
    required this.columns,
  });
}