part of 'single_integral_bloc.dart';

@immutable
sealed class SingleIntegralEvent extends Equatable {
  const SingleIntegralEvent();
}

final class SingleIntegralRequested extends SingleIntegralEvent {
  final IntegralRequest request;
  const SingleIntegralRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class SingleIntegralReset extends SingleIntegralEvent {
  const SingleIntegralReset();
  @override
  List<Object> get props => [];
}
