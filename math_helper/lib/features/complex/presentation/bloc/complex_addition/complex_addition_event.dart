part of 'complex_addition_bloc.dart';

@immutable
sealed class ComplexAdditionEvent extends Equatable {
  const ComplexAdditionEvent();
}

final class ComplexAdditionRequested extends ComplexAdditionEvent {
  final ComplexOperationsRequest request;
  const ComplexAdditionRequested({required this.request});

  @override
  List<Object> get props => [request];
}

final class ComplexAdditionReset extends ComplexAdditionEvent {
  const ComplexAdditionReset();

  @override
  List<Object> get props => [];
}
