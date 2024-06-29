part of 'second_order_differential_equation_bloc.dart';

@immutable
sealed class SecondOrderDifferentialEquationState {}

final class SecondOrderDifferentialEquationInitial
    extends SecondOrderDifferentialEquationState {}

final class SecondOrderDifferentialEquationLoading
    extends SecondOrderDifferentialEquationState {}

final class SecondOrderDifferentialEquationSuccess
    extends SecondOrderDifferentialEquationState {
  final DifferentialEquationResponse response;
  SecondOrderDifferentialEquationSuccess({required this.response});
}

final class SecondOrderDifferentialEquationFailure
    extends SecondOrderDifferentialEquationState {
  final String message;
  SecondOrderDifferentialEquationFailure({required this.message});
}
