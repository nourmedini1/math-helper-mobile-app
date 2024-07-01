part of 'solve_linear_system_bloc.dart';

@immutable
sealed class SolveLinearSystemState {}

final class SolveLinearSystemInitial extends SolveLinearSystemState {}

final class SolveLinearSystemLoading extends SolveLinearSystemState {}

final class SolveLinearSystemSuccess extends SolveLinearSystemState {
  final LinearSystemResponse response;
  SolveLinearSystemSuccess({required this.response});
}

final class SolveLinearSystemFailure extends SolveLinearSystemState {
  final String message;
  SolveLinearSystemFailure({required this.message});
}
