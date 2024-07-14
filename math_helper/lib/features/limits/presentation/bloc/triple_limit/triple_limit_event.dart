part of 'triple_limit_bloc.dart';

@immutable
sealed class TripleLimitEvent extends Equatable {
  const TripleLimitEvent();
}

final class TripleLimitRequested extends TripleLimitEvent {
  final LimitRequest request;
  const TripleLimitRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class TripleLimitReset extends TripleLimitEvent {
  const TripleLimitReset();
  @override
  List<Object> get props => [];
}
