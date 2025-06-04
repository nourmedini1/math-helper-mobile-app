part of 'addition_cubit.dart';

@immutable
sealed class AdditionState {}

final class AdditionFieldsReady extends AdditionState {}

final class AdditionFieldsMissing extends AdditionState {}
