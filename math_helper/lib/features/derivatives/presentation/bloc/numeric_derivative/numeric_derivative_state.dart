part of 'numeric_derivative_bloc.dart';

@immutable
sealed class NumericDerivativeState {}

final class NumericDerivativeInitial extends NumericDerivativeState {}

final class NumericDerivativeLoading extends NumericDerivativeState {}

final class NumericDerivativeSuccess extends NumericDerivativeState {
  final DerivativeResponse response;

  NumericDerivativeSuccess({required this.response});
}

final class NumericDerivativeFailure extends NumericDerivativeState {
  final String message;

  NumericDerivativeFailure({required this.message});
}
