part of 'determinant_matrix_fields_cubit.dart';

@immutable
sealed class DeterminantMatrixFieldsState {}

final class DeterminantMatrixFieldsMissing extends DeterminantMatrixFieldsState {}
final class DeterminantMatrixFieldsReady extends DeterminantMatrixFieldsState {}
