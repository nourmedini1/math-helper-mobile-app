part of 'double_primitive_bloc.dart';

@immutable
sealed class DoublePrimitiveEvent {
  final IntegralRequest request;
  const DoublePrimitiveEvent({required this.request});
}
