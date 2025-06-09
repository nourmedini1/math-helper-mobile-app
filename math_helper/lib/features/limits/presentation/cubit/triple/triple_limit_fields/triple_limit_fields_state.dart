part of 'triple_limit_fields_cubit.dart';

@immutable
sealed class TripleLimitFieldsState {}

final class TripleLimitFieldsMissing extends TripleLimitFieldsState {}
final class TripleLimitFieldsReady extends TripleLimitFieldsState {}
