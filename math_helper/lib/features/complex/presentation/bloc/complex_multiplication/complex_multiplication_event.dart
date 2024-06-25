part of 'complex_multiplication_bloc.dart';

@immutable
sealed class ComplexMultiplicationEvent {
  final ComplexOperationsRequest request;
  const ComplexMultiplicationEvent({required this.request});
}
