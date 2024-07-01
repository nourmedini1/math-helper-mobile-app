part of 'eigen_bloc.dart';

@immutable
sealed class EigenEvent {
  final MatrixRequest request;

  const EigenEvent({required this.request});
}
