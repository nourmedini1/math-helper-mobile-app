part of 'complex_multiplication_bloc.dart';

@immutable
sealed class ComplexMultiplicationState {}

final class ComplexMultiplicationInitial extends ComplexMultiplicationState {}

final class ComplexMultiplicationLoading extends ComplexMultiplicationState {}

final class ComplexMultiplicationSuccess extends ComplexMultiplicationState {
  final ComplexOperationsResponse response;

  ComplexMultiplicationSuccess({required this.response});
}

final class ComplexMultiplicationFailure extends ComplexMultiplicationState {
  final String message;

  ComplexMultiplicationFailure({required this.message});
}
