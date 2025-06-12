part of 'first_graph_fields_cubit.dart';

@immutable
sealed class FirstGraphFieldsState {}

final class FirstGraphFieldsMissing extends FirstGraphFieldsState {}
final class FirstGraphFieldsReady extends FirstGraphFieldsState {
}
