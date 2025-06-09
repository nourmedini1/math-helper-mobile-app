part of 'single_fields_cubit.dart';

@immutable
sealed class SingleFieldsState {}

final class SingleFieldsMissing extends SingleFieldsState {}
final class SingleFieldsReady extends SingleFieldsState {}
