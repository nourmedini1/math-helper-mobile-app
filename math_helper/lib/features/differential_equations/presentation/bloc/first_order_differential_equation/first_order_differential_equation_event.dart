part of 'first_order_differential_equation_bloc.dart';

@immutable
sealed class FirstOrderDifferentialEquationEvent extends Equatable {
  const FirstOrderDifferentialEquationEvent();
}

final class FirstOrderDifferentialEquationRequested
    extends FirstOrderDifferentialEquationEvent {
  final DifferentialEquationRequest request;
  const FirstOrderDifferentialEquationRequested({required this.request});

  @override
  List<Object> get props => [request];
}

final class FirstOrderDifferentialEquationReset
    extends FirstOrderDifferentialEquationEvent {
  const FirstOrderDifferentialEquationReset();

  @override
  List<Object> get props => [];
}
