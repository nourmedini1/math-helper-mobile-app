part of 'numeric_sum_bloc.dart';

@immutable
sealed class NumericSumState {}

final class NumericSumInitial extends NumericSumState {}

final class NumericSumLoading extends NumericSumState {}

final class NumericSumSuccess extends NumericSumState {
  final SumResponse response;
  NumericSumSuccess({required this.response});
}

final class NumericSumFailure extends NumericSumState {
  final String message;
  NumericSumFailure({required this.message});
}
