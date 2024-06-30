part of 'symbolic_sum_bloc.dart';

@immutable
sealed class SymbolicSumState {}

final class SymbolicSumInitial extends SymbolicSumState {}

final class SymbolicSumLoading extends SymbolicSumState {}

final class SymbolicSumSuccess extends SymbolicSumState {
  final SumResponse response;
  SymbolicSumSuccess({required this.response});
}

final class SymbolicSumFailure extends SymbolicSumState {
  final String message;
  SymbolicSumFailure({required this.message});
}
