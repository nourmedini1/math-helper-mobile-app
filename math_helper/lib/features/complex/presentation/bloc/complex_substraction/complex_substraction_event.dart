part of 'complex_substraction_bloc.dart';

@immutable
sealed class ComplexSubstractionEvent {
  final ComplexOperationsRequest request;
  const ComplexSubstractionEvent({required this.request});
}
