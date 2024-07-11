part of 'complex_multiplication_bloc.dart';

@immutable
sealed class ComplexMultiplicationEvent extends Equatable {
  const ComplexMultiplicationEvent();
}

final class ComplexMultiplicationRequested extends ComplexMultiplicationEvent {
  final ComplexOperationsRequest request;
  const ComplexMultiplicationRequested({required this.request});

  @override
  List<Object> get props => [request];
}

final class ComplexMultiplicationReset extends ComplexMultiplicationEvent {
  const ComplexMultiplicationReset();

  @override
  List<Object> get props => [];
}
