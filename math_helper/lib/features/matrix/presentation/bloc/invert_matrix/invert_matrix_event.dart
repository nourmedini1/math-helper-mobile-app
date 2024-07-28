part of 'invert_matrix_bloc.dart';

@immutable
sealed class InvertMatrixEvent extends Equatable {}

class InvertMatrixRequested extends InvertMatrixEvent {
  final MatrixRequest request;

  InvertMatrixRequested({required this.request});

  @override
  List<Object?> get props => [request];
}

class InvertMatrixReset extends InvertMatrixEvent {
  InvertMatrixReset();

  @override
  List<Object?> get props => [];
}
