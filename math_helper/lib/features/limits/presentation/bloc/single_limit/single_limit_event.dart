part of 'single_limit_bloc.dart';

@immutable
sealed class SingleLimitEvent {
  final LimitRequest request;
  const SingleLimitEvent({required this.request});
}
