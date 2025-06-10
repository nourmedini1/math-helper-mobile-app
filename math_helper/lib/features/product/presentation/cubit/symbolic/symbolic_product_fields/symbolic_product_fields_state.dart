part of 'symbolic_product_fields_cubit.dart';

@immutable
sealed class SymbolicProductFieldsState {}

final class SymbolicProductFieldsMissing extends SymbolicProductFieldsState {}
final class SymbolicProductFieldsReady extends SymbolicProductFieldsState {}
