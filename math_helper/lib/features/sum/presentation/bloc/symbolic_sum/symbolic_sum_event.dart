part of 'symbolic_sum_bloc.dart';

@immutable
sealed class SymbolicSumEvent {
  final SumRequest request;
  const SymbolicSumEvent({required this.request});
}
