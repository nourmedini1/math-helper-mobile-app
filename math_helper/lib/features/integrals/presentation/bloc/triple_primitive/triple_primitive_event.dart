part of 'triple_primitive_bloc.dart';

@immutable
sealed class TriplePrimitiveEvent extends Equatable {
  const TriplePrimitiveEvent();
}

final class TriplePrimitiveRequested extends TriplePrimitiveEvent {
  final IntegralRequest request;
  const TriplePrimitiveRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class TriplePrimitiveReset extends TriplePrimitiveEvent {
  const TriplePrimitiveReset();
  @override
  List<Object> get props => [];
}
