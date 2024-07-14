part of 'multiply_matrix_bloc.dart';

@immutable
sealed class MultiplyMatrixEvent extends Equatable {
  const MultiplyMatrixEvent();
}

final class MultiplyMatrixRequested extends MultiplyMatrixEvent {
  final MatrixRequest request;
  const MultiplyMatrixRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class MultiplyMatrixReset extends MultiplyMatrixEvent {
  const MultiplyMatrixReset();
  @override
  List<Object> get props => [];
}
