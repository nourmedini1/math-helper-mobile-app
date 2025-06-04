part of 'symbolic_derivative_fields_cubit.dart';

@immutable
sealed class SymbolicDerivativeFieldsState {}

final class SymbolicDerivativeFieldsMissing extends SymbolicDerivativeFieldsState {}
final class SymbolicDerivativeFieldsReady extends SymbolicDerivativeFieldsState {}
