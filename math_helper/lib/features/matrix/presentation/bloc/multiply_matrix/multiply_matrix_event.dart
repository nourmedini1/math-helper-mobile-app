part of 'multiply_matrix_bloc.dart';

@immutable
sealed class MultiplyMatrixEvent {
  final MatrixRequest request;

  const MultiplyMatrixEvent({required this.request});
}
