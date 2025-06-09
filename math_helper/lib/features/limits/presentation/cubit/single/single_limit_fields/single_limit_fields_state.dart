part of 'single_limit_fields_cubit.dart';

@immutable
sealed class SingleLimitFieldsState {}

final class SingleLimitFieldsMissing extends SingleLimitFieldsState {}
final class SingleLimitFieldsReady extends SingleLimitFieldsState {}
