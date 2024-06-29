part of 'first_order_differential_equation_bloc.dart';

@immutable
sealed class FirstOrderDifferentialEquationEvent {
  final DifferentialEquationRequest request;
  const FirstOrderDifferentialEquationEvent({required this.request});
}
