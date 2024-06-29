part of 'double_primitive_bloc.dart';

@immutable
sealed class DoublePrimitiveState {}

final class DoublePrimitiveInitial extends DoublePrimitiveState {}

final class DoublePrimitiveLoading extends DoublePrimitiveState {}

final class DoublePrimitiveSuccess extends DoublePrimitiveState {
  final IntegralResponse integralResponse;
  DoublePrimitiveSuccess({required this.integralResponse});
}

final class DoublePrimitiveFailure extends DoublePrimitiveState {
  final String message;
  DoublePrimitiveFailure({required this.message});
}
