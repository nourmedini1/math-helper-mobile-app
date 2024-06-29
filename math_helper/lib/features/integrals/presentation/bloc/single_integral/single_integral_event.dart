part of 'single_integral_bloc.dart';

@immutable
sealed class SingleIntegralEvent {
  final IntegralRequest request;
  const SingleIntegralEvent({required this.request});
}
