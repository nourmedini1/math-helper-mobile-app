part of 'solve_linear_system_bloc.dart';

@immutable
sealed class SolveLinearSystemEvent {
  final LinearSystemRequest request;
  const SolveLinearSystemEvent({required this.request});
}
