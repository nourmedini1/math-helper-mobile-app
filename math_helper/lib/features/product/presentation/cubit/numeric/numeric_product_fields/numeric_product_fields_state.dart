part of 'numeric_product_fields_cubit.dart';

@immutable
sealed class NumericProductFieldsState {}

final class NumericProductFieldsMissing extends NumericProductFieldsState {}
final class NumericProductFieldsReady extends NumericProductFieldsState {}
