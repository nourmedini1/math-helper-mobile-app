part of 'indefinite_single_fields_cubit.dart';

@immutable
sealed class IndefiniteSingleFieldsState {}

final class IndefiniteSingleFieldsMissing extends IndefiniteSingleFieldsState {}
final class IndefiniteSingleFieldsReady extends IndefiniteSingleFieldsState {}
