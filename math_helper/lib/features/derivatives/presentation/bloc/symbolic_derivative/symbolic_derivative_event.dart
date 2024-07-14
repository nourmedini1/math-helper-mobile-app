part of 'symbolic_derivative_bloc.dart';

@immutable
sealed class SymbolicDerivativeEvent extends Equatable {
  const SymbolicDerivativeEvent();
}

final class SymbolicDerivativeRequested extends SymbolicDerivativeEvent {
  final DerivativeRequest request;
  const SymbolicDerivativeRequested({required this.request});

  @override
  List<Object> get props => [request];
}

final class SymbolicDerivativeReset extends SymbolicDerivativeEvent {
  const SymbolicDerivativeReset();

  @override
  List<Object> get props => [];
}
