part of 'second_graph_fields_cubit.dart';

@immutable
sealed class SecondGraphFieldsState {}

final class SecondGraphFieldsMissing extends SecondGraphFieldsState {}
final class SecondGraphFieldsReady extends SecondGraphFieldsState {}
