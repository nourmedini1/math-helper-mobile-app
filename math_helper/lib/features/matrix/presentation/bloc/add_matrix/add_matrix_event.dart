part of 'add_matrix_bloc.dart';

@immutable
sealed class AddMatrixEvent extends Equatable {
  const AddMatrixEvent();
}

final class AddMatrixRequested extends AddMatrixEvent {
  final MatrixRequest request;
  const AddMatrixRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class AddMatrixReset extends AddMatrixEvent {
  const AddMatrixReset();
  @override
  List<Object> get props => [];
}
