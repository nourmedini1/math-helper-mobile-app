part of 'complex_substraction_bloc.dart';

@immutable
sealed class ComplexSubstractionState {}

final class ComplexSubstractionInitial extends ComplexSubstractionState {}

final class ComplexSubstractionLoading extends ComplexSubstractionState {}

final class ComplexSubstractionOperationSuccess
    extends ComplexSubstractionState {
  final ComplexOperationsResponse response;

  ComplexSubstractionOperationSuccess({required this.response});
}

final class ComplexSubstractionFailure extends ComplexSubstractionState {
  final String message;

  ComplexSubstractionFailure({required this.message});
}
