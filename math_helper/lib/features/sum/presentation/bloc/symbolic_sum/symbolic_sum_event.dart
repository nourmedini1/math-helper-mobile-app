part of 'symbolic_sum_bloc.dart';

@immutable
sealed class SymbolicSumEvent extends Equatable {
  const SymbolicSumEvent();
}

final class SymbolicSumRequested extends SymbolicSumEvent {
  final SumRequest request;
  const SymbolicSumRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class SymbolicSumReset extends SymbolicSumEvent {
  const SymbolicSumReset();
  @override
  List<Object> get props => [];
}
