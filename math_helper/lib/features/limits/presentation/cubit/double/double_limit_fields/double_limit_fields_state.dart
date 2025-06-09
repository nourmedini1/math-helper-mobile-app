part of 'double_limit_fields_cubit.dart';

@immutable
sealed class DoubleLimitFieldsState {}

final class DoubleLimitFieldsMissing extends DoubleLimitFieldsState {}
final class DoubleLimitFieldsReady extends DoubleLimitFieldsState {}
