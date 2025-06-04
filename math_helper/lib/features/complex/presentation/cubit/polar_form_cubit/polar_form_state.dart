part of 'polar_form_cubit.dart';

@immutable
sealed class PolarFormCubitState {}

final class PolarFormFieldsReady extends PolarFormCubitState {}
final class PolarFormFieldsMissing extends PolarFormCubitState {}

