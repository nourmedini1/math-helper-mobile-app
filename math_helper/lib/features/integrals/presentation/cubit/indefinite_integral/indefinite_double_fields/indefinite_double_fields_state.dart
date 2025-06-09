part of 'indefinite_double_fields_cubit.dart';

@immutable
sealed class IndefiniteDoubleFieldsState {}

final class IndefiniteDoubleFieldsMissing extends IndefiniteDoubleFieldsState {}
final class IndefiniteDoubleFieldsReady extends IndefiniteDoubleFieldsState {}
