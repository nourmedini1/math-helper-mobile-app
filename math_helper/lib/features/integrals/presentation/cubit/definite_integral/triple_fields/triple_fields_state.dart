part of 'triple_fields_cubit.dart';

@immutable
sealed class TripleFieldsState {}

final class TripleFieldsMissing extends TripleFieldsState {}
final class TripleFieldsReady extends TripleFieldsState {}
