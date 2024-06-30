part of 'single_limit_bloc.dart';

@immutable
sealed class SingleLimitState {}

final class SingleLimitInitial extends SingleLimitState {}

final class SingleLimitLoading extends SingleLimitState {}

final class SingleLimitSuccess extends SingleLimitState {
  final LimitResponse response;

  SingleLimitSuccess({required this.response});
}

final class SingleLimitFailure extends SingleLimitState {
  final String message;

  SingleLimitFailure({required this.message});
}
