part of 'triple_limit_bloc.dart';

@immutable
sealed class TripleLimitEvent {
  final LimitRequest request;
  const TripleLimitEvent({required this.request});
}
