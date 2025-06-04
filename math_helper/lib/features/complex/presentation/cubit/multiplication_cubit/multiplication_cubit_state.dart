part of 'multiplication_cubit.dart';

@immutable
sealed class MultiplicationState {}

final class MultiplicationFieldsReady extends MultiplicationState {}
final class MultiplicationFieldsMissing extends MultiplicationState {}



