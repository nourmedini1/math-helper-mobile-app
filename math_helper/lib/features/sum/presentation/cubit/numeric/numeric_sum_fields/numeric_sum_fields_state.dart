part of 'numeric_sum_fields_cubit.dart';

@immutable
sealed class NumericSumFieldsState {}

final class NumericSumFieldsMissing extends NumericSumFieldsState {}
final class NumericSumFieldsReady extends NumericSumFieldsState {}
