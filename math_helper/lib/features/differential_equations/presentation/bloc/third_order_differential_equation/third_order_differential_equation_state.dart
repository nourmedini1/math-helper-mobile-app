part of 'third_order_differential_equation_bloc.dart';

@immutable
sealed class ThirdOrderDifferentialEquationState {}

final class ThirdOrderDifferentialEquationInitial
    extends ThirdOrderDifferentialEquationState {}

final class ThirdOrderDifferentialEquationLoading
    extends ThirdOrderDifferentialEquationState {}

final class ThirdOrderDifferentialEquationSuccess
    extends ThirdOrderDifferentialEquationState {
  final DifferentialEquationResponse response;
  ThirdOrderDifferentialEquationSuccess({required this.response});
}

final class ThirdOrderDifferentialEquationFailure
    extends ThirdOrderDifferentialEquationState {
  final String message;
  ThirdOrderDifferentialEquationFailure({required this.message});
}
