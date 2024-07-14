part of 'double_limit_bloc.dart';

@immutable
sealed class DoubleLimitEvent extends Equatable {
  const DoubleLimitEvent();
}

final class DoubleLimitRequested extends DoubleLimitEvent {
  final LimitRequest request;
  const DoubleLimitRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class DoubleLimitReset extends DoubleLimitEvent {
  const DoubleLimitReset();
  @override
  List<Object> get props => [];
}
