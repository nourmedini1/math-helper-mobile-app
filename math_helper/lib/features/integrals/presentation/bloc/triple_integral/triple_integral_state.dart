part of 'triple_integral_bloc.dart';

@immutable
sealed class TripleIntegralState {}

final class TripleIntegralInitial extends TripleIntegralState {}

final class TripleIntegralLoading extends TripleIntegralState {}

final class TripleIntegralSuccess extends TripleIntegralState {
  final IntegralResponse response;
  TripleIntegralSuccess({required this.response});
}

final class TripleIntegralFailure extends TripleIntegralState {
  final String message;
  TripleIntegralFailure({required this.message});
}
