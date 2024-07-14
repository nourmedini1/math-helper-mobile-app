part of 'single_primitive_bloc.dart';

@immutable
sealed class SinglePrimitiveEvent extends Equatable {
  const SinglePrimitiveEvent();
}

final class SinglePrimitiveRequested extends SinglePrimitiveEvent {
  final IntegralRequest request;
  const SinglePrimitiveRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class SinglePrimitiveReset extends SinglePrimitiveEvent {
  const SinglePrimitiveReset();
  @override
  List<Object> get props => [];
}
