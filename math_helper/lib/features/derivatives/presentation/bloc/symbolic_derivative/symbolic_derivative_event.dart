part of 'symbolic_derivative_bloc.dart';

@immutable
sealed class SymbolicDerivativeEvent {
  final DerivativeRequest request;
  const SymbolicDerivativeEvent({required this.request});
}
