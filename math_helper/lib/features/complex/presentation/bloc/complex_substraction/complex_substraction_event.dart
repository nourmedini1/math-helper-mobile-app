part of 'complex_substraction_bloc.dart';

@immutable
sealed class ComplexSubstractionEvent extends Equatable {
  const ComplexSubstractionEvent();
}

final class ComplexSubstractionRequested extends ComplexSubstractionEvent {
  final ComplexOperationsRequest request;
  const ComplexSubstractionRequested({required this.request});

  @override
  List<Object> get props => [request];
}

final class ComplexSubstractionReset extends ComplexSubstractionEvent {
  const ComplexSubstractionReset();
  @override
  List<Object> get props => [];
}
