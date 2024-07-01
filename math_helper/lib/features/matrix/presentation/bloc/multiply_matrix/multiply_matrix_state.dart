part of 'multiply_matrix_bloc.dart';

@immutable
sealed class MultiplyMatrixState {}

final class MultiplyMatrixInitial extends MultiplyMatrixState {}

final class MultiplyMatrixLoading extends MultiplyMatrixState {}

final class MultiplyMatrixSuccess extends MultiplyMatrixState {
  final MatrixResponse response;

  MultiplyMatrixSuccess({required this.response});
}

final class MultiplyMatrixFailure extends MultiplyMatrixState {
  final String message;

  MultiplyMatrixFailure({required this.message});
}
