part of 'numeric_derivative_fields_cubit.dart';

@immutable
sealed class NumericDerivativeFieldsState {}

final class NumericDerivativeFieldsMissing extends NumericDerivativeFieldsState {}
final class NumericDerivativeFieldsReady extends NumericDerivativeFieldsState {}
