part of 'invert_matrix_fields_cubit.dart';

@immutable
sealed class InvertMatrixFieldsState {}

final class InvertMatrixFieldsMissing extends InvertMatrixFieldsState {}
final class InvertMatrixFieldsReady extends InvertMatrixFieldsState {}
