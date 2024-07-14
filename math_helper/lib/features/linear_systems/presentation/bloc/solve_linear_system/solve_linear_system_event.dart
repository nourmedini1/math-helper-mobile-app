part of 'solve_linear_system_bloc.dart';

@immutable
sealed class SolveLinearSystemEvent extends Equatable {
  const SolveLinearSystemEvent();
}

final class SolveLinearSystemRequested extends SolveLinearSystemEvent {
  final LinearSystemRequest request;
  const SolveLinearSystemRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class SolveLinearSystemReset extends SolveLinearSystemEvent {
  const SolveLinearSystemReset();
  @override
  List<Object> get props => [];
}
