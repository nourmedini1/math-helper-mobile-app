part of 'second_order_differential_equation_bloc.dart';

@immutable
sealed class SecondOrderDifferentialEquationEvent extends Equatable {
  const SecondOrderDifferentialEquationEvent();
}

final class SecondOrderDifferentialEquationRequested
    extends SecondOrderDifferentialEquationEvent {
  final DifferentialEquationRequest request;
  const SecondOrderDifferentialEquationRequested({required this.request});

  @override
  List<Object> get props => [request];
}

final class SecondOrderDifferentialEquationReset
    extends SecondOrderDifferentialEquationEvent {
  const SecondOrderDifferentialEquationReset();

  @override
  List<Object> get props => [];
}
