part of 'determinant_bloc.dart';

@immutable
sealed class DeterminantState {}

final class DeterminantInitial extends DeterminantState {}

final class DeterminantLoading extends DeterminantState {}

final class DeterminantSuccess extends DeterminantState {
  final MatrixResponse response;

  DeterminantSuccess({required this.response});
}

final class DeterminantFailure extends DeterminantState {
  final String message;

  DeterminantFailure({required this.message});
}
