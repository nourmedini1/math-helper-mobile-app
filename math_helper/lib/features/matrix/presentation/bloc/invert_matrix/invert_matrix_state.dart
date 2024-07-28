part of 'invert_matrix_bloc.dart';

@immutable
sealed class InvertMatrixState extends Equatable {}

final class InvertMatrixInitial extends InvertMatrixState {
  @override
  List<Object?> get props => [];
}

final class InvertMatrixLoading extends InvertMatrixState {
  @override
  List<Object?> get props => [];
}

final class InvertMatrixSuccess extends InvertMatrixState {
  final MatrixResponse response;

  InvertMatrixSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

final class InvertMatrixFailure extends InvertMatrixState {
  final String message;

  InvertMatrixFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
