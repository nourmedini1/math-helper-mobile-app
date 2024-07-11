part of 'complex_addition_bloc.dart';

@immutable
sealed class ComplexAdditionState {}

final class ComplexAdditionInitial extends ComplexAdditionState {}

final class ComplexAdditionLoading extends ComplexAdditionState {}

final class ComplexAdditionSuccess extends ComplexAdditionState {
  final ComplexOperationsResponse response;

  ComplexAdditionSuccess({required this.response});
}

final class ComplexAdditionFailure extends ComplexAdditionState {
  final String message;

  ComplexAdditionFailure({required this.message});
}
