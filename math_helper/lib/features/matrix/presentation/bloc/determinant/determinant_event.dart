part of 'determinant_bloc.dart';

@immutable
sealed class DeterminantEvent {
  final MatrixRequest request;

  const DeterminantEvent({required this.request});
}
