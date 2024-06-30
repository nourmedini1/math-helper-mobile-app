part of 'numeric_sum_bloc.dart';

@immutable
sealed class NumericSumEvent {
  final SumRequest request;
  const NumericSumEvent({required this.request});
}
