part of 'double_integral_bloc.dart';

@immutable
sealed class DoubleIntegralEvent {
  final IntegralRequest request;
  const DoubleIntegralEvent({required this.request});
}
