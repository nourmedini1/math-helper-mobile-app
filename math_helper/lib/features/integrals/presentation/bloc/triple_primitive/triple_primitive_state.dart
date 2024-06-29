part of 'triple_primitive_bloc.dart';

@immutable
sealed class TriplePrimitiveState {}

final class TriplePrimitiveInitial extends TriplePrimitiveState {}

final class TriplePrimitiveLoading extends TriplePrimitiveState {}

final class TriplePrimitiveSuccess extends TriplePrimitiveState {
  final IntegralResponse integralResponse;
  TriplePrimitiveSuccess({required this.integralResponse});
}

final class TriplePrimitiveFailure extends TriplePrimitiveState {
  final String message;
  TriplePrimitiveFailure({required this.message});
}
