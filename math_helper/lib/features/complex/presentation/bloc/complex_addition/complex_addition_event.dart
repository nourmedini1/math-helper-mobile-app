part of 'complex_addition_bloc.dart';

@immutable
sealed class ComplexAdditionEvent extends Equatable {
  final ComplexOperationsRequest request;
  const ComplexAdditionEvent({required this.request});
}
