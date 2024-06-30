part of 'triple_limit_bloc.dart';

@immutable
sealed class TripleLimitState {}

final class TripleLimitInitial extends TripleLimitState {}

final class TripleLimitLoading extends TripleLimitState {}

final class TripleLimitSuccess extends TripleLimitState {
  final LimitResponse response;

  TripleLimitSuccess({required this.response});
}

final class TripleLimitFailure extends TripleLimitState {
  final String message;

  TripleLimitFailure({required this.message});
}
