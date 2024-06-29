part of 'triple_primitive_bloc.dart';

@immutable
sealed class TriplePrimitiveEvent {
  final IntegralRequest request;
  const TriplePrimitiveEvent({required this.request});
}
