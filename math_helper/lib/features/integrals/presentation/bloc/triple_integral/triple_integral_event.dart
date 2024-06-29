part of 'triple_integral_bloc.dart';

@immutable
sealed class TripleIntegralEvent {
  final IntegralRequest request;
  const TripleIntegralEvent({required this.request});
}
