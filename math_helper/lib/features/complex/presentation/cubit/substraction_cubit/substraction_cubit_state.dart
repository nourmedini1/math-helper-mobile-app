part of 'substraction_cubit.dart';

@immutable
sealed class SubstractionState {}

final class SubstractionFieldsReady extends SubstractionState {}
final class SubstractionFieldsMissing extends SubstractionState {}


