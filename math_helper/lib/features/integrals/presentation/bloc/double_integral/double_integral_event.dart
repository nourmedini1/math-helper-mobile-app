part of 'double_integral_bloc.dart';

@immutable
sealed class DoubleIntegralEvent extends Equatable {
  const DoubleIntegralEvent();
}

final class DoubleIntegralRequested extends DoubleIntegralEvent {
  final IntegralRequest request;
  const DoubleIntegralRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class DoubleIntegralReset extends DoubleIntegralEvent {
  const DoubleIntegralReset();
  @override
  List<Object> get props => [];
}
