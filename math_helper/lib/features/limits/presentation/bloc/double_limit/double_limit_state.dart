part of 'double_limit_bloc.dart';

@immutable
sealed class DoubleLimitState {}

final class DoubleLimitInitial extends DoubleLimitState {}

final class DoubleLimitLoading extends DoubleLimitState {}

final class DoubleLimitSuccess extends DoubleLimitState {
  final LimitResponse response;

  DoubleLimitSuccess({required this.response});
}

final class DoubleLimitFailure extends DoubleLimitState {
  final String message;

  DoubleLimitFailure({required this.message});
}
