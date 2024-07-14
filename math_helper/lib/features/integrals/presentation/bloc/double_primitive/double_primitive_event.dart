part of 'double_primitive_bloc.dart';

@immutable
sealed class DoublePrimitiveEvent extends Equatable {
  const DoublePrimitiveEvent();
}

final class DoublePrimitiveRequested extends DoublePrimitiveEvent {
  final IntegralRequest request;
  const DoublePrimitiveRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class DoublePrimitiveReset extends DoublePrimitiveEvent {
  const DoublePrimitiveReset();
  @override
  List<Object> get props => [];
}
