part of 'numeric_derivative_bloc.dart';

@immutable
sealed class NumericDerivativeEvent {
  final DerivativeRequest request;
  const NumericDerivativeEvent({required this.request});
}
