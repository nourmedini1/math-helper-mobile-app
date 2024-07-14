part of 'single_limit_bloc.dart';

@immutable
sealed class SingleLimitEvent extends Equatable {
  const SingleLimitEvent();
}

final class SingleLimitRequested extends SingleLimitEvent {
  final LimitRequest request;
  const SingleLimitRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class SingleLimitReset extends SingleLimitEvent {
  const SingleLimitReset();
  @override
  List<Object> get props => [];
}
