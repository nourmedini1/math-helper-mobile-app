part of 'rank_matrix_fields_cubit.dart';

@immutable
sealed class RankMatrixFieldsState {}

final class RankMatrixFieldsMissing extends RankMatrixFieldsState {}
final class RankMatrixFieldsReady extends RankMatrixFieldsState {}
