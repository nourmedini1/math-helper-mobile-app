part of 'linear_system_equations_cubit.dart';

@immutable
sealed class LinearSystemEquationsState {}

final class LinearSystemEquationsInitial extends LinearSystemEquationsState {}
final class LinearSystemEquationsGenerated extends LinearSystemEquationsState {
  final int nbEquations;
  final List<String> variables;

  LinearSystemEquationsGenerated({
    required this.nbEquations,
    required this.variables,
  });
}

