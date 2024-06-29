part of 'single_primitive_bloc.dart';

@immutable
sealed class SinglePrimitiveState {}

final class SinglePrimitiveInitial extends SinglePrimitiveState {}

final class SinglePrimitiveLoading extends SinglePrimitiveState {}

final class SinglePrimitiveSuccess extends SinglePrimitiveState {
  final IntegralResponse integralResponse;
  SinglePrimitiveSuccess({required this.integralResponse});
}

final class SinglePrimitiveFailure extends SinglePrimitiveState {
  final String message;
  SinglePrimitiveFailure({required this.message});
}
