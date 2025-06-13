part of 'rank_matrix_cubit.dart';

@immutable
sealed class RankMatrixState {}

final class RankMatrixInitial extends RankMatrixState {}
final class RankMatrixGenerated extends RankMatrixState {
  final int rows;
  final int columns;
  RankMatrixGenerated({
    required this.rows,
    required this.columns,
  });
}
