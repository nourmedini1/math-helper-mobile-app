part of 'symbolic_sum_fields_cubit.dart';

@immutable
sealed class SymbolicSumFieldsState {}

final class SymbolicSumFieldsMissing extends SymbolicSumFieldsState {}
final class SymbolicSumFieldsReady extends SymbolicSumFieldsState {}
