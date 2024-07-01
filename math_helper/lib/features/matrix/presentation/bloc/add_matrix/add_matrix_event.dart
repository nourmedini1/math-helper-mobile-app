part of 'add_matrix_bloc.dart';

@immutable
sealed class AddMatrixEvent {
  final MatrixRequest request;

  const AddMatrixEvent({required this.request});
}
