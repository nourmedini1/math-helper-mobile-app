part of 'third_order_differential_equation_bloc.dart';

@immutable
sealed class ThirdOrderDifferentialEquationEvent {
  final DifferentialEquationRequest request;
  const ThirdOrderDifferentialEquationEvent({required this.request});
}
