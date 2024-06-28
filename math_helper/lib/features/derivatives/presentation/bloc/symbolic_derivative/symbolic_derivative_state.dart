part of 'symbolic_derivative_bloc.dart';

@immutable
sealed class SymbolicDerivativeState {}

final class SymbolicDerivativeInitial extends SymbolicDerivativeState {}

final class SymbolicDerivativeLoading extends SymbolicDerivativeState {}

final class SymbolicDerivativeSuccess extends SymbolicDerivativeState {
  final DerivativeResponse response;

  SymbolicDerivativeSuccess({required this.response});
}

final class SymbolicDerivativeFailure extends SymbolicDerivativeState {
  final String message;

  SymbolicDerivativeFailure({required this.message});
}
