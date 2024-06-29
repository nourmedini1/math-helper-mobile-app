part of 'first_order_differential_equation_bloc.dart';

@immutable
sealed class FirstOrderDifferentialEquationState {}

final class FirstOrderDifferentialEquationInitial
    extends FirstOrderDifferentialEquationState {}

final class FirstOrderDifferentialEquationLoading
    extends FirstOrderDifferentialEquationState {}

final class FirstOrderDifferentialEquationSuccess
    extends FirstOrderDifferentialEquationState {
  final DifferentialEquationResponse response;
  FirstOrderDifferentialEquationSuccess({required this.response});
}

final class FirstOrderDifferentialEquationFailure
    extends FirstOrderDifferentialEquationState {
  final String message;
  FirstOrderDifferentialEquationFailure({required this.message});
}
