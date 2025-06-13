part of 'addition_first_matrix_cubit.dart';

@immutable
sealed class AdditionFirstMatrixState {}

final class AdditionFirstMatrixInitial extends AdditionFirstMatrixState {}
final class AdditionFirstMatrixGenerated extends AdditionFirstMatrixState {
  final int rows;
  final int columns;
  AdditionFirstMatrixGenerated({
    required this.rows,
    required this.columns,
  });


}
