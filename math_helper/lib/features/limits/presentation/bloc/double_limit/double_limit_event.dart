part of 'double_limit_bloc.dart';

@immutable
sealed class DoubleLimitEvent {
  final LimitRequest request;
  const DoubleLimitEvent({required this.request});
}
