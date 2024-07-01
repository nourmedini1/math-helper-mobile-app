part of 'add_matrix_bloc.dart';

@immutable
sealed class AddMatrixState {}

final class AddMatrixInitial extends AddMatrixState {}

final class AddMatrixLoading extends AddMatrixState {}

final class AddMatrixSuccess extends AddMatrixState {
  final MatrixResponse response;

  AddMatrixSuccess({required this.response});
}

final class AddMatrixFailure extends AddMatrixState {
  final String message;

  AddMatrixFailure({required this.message});
}
