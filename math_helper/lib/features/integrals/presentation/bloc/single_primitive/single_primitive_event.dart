part of 'single_primitive_bloc.dart';

@immutable
sealed class SinglePrimitiveEvent {
  final IntegralRequest request;
  const SinglePrimitiveEvent({required this.request});
}
