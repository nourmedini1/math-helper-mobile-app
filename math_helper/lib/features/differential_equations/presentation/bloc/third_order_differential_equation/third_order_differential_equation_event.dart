part of 'third_order_differential_equation_bloc.dart';

@immutable
sealed class ThirdOrderDifferentialEquationEvent extends Equatable {
  const ThirdOrderDifferentialEquationEvent();
}

final class ThirdOrderDifferentialEquationRequested
    extends ThirdOrderDifferentialEquationEvent {
  final DifferentialEquationRequest request;
  const ThirdOrderDifferentialEquationRequested({required this.request});

  @override
  String toString() =>
      'ThirdOrderDifferentialEquationRequested(request: $request)';

  @override
  List<Object> get props => [request];
}

final class ThirdOrderDifferentialEquationReset
    extends ThirdOrderDifferentialEquationEvent {
  const ThirdOrderDifferentialEquationReset();

  @override
  String toString() => 'ThirdOrderDifferentialEquationReset()';

  @override
  List<Object> get props => [];
}
