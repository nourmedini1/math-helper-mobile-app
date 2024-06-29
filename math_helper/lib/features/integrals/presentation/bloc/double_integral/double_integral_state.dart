part of 'double_integral_bloc.dart';

@immutable
sealed class DoubleIntegralState {}

final class DoubleIntegralInitial extends DoubleIntegralState {}

final class DoubleIntegralLoading extends DoubleIntegralState {}

final class DoubleIntegralSuccess extends DoubleIntegralState {
  final IntegralResponse integralResponse;
  DoubleIntegralSuccess({required this.integralResponse});
}

final class DoubleIntegralFailure extends DoubleIntegralState {
  final String message;
  DoubleIntegralFailure({required this.message});
}
