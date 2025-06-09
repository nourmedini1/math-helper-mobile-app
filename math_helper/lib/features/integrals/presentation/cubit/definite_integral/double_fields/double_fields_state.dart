part of 'double_fields_cubit.dart';

@immutable
sealed class DoubleFieldsState {}

final class DoubleFieldsMissing extends DoubleFieldsState {}
final class DoubleFieldsReady extends DoubleFieldsState {}
