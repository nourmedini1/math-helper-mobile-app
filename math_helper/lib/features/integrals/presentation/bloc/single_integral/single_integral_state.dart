part of 'single_integral_bloc.dart';

@immutable
sealed class SingleIntegralState {}

final class SingleIntegralInitial extends SingleIntegralState {}

final class SingleIntegralLoading extends SingleIntegralState {}

final class SingleIntegralSuccess extends SingleIntegralState {
  final IntegralResponse integralResponse;
  SingleIntegralSuccess({required this.integralResponse});
}

final class SingleIntegralFailure extends SingleIntegralState {
  final String message;
  SingleIntegralFailure({required this.message});
}
