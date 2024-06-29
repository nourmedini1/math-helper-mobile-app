part of 'second_order_differential_equation_bloc.dart';

@immutable
sealed class SecondOrderDifferentialEquationEvent {
  final DifferentialEquationRequest request;
  const SecondOrderDifferentialEquationEvent({required this.request});
}
