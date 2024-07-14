part of 'triple_integral_bloc.dart';

@immutable
sealed class TripleIntegralEvent extends Equatable {
  const TripleIntegralEvent();
}

final class TripleIntegralRequested extends TripleIntegralEvent {
  final IntegralRequest request;
  const TripleIntegralRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class TripleIntegralReset extends TripleIntegralEvent {
  const TripleIntegralReset();
  @override
  List<Object> get props => [];
}
