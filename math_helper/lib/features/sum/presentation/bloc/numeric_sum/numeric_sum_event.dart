part of 'numeric_sum_bloc.dart';

@immutable
sealed class NumericSumEvent extends Equatable {
  const NumericSumEvent();
}

final class NumericSumRequested extends NumericSumEvent {
  final SumRequest request;
  const NumericSumRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class NumericSumReset extends NumericSumEvent {
  const NumericSumReset();
  @override
  List<Object> get props => [];
}
