part of 'eigen_matrix_fields_cubit.dart';

@immutable
sealed class EigenMatrixFieldsState {}

final class EigenMatrixFieldsMissing extends EigenMatrixFieldsState {}
final class EigenMatrixFieldsReady extends EigenMatrixFieldsState {}
