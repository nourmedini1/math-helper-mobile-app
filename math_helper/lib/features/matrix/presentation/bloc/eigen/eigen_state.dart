part of 'eigen_bloc.dart';

@immutable
sealed class EigenState {}

final class EigenInitial extends EigenState {}

final class EigenLoading extends EigenState {}

final class EigenSuccess extends EigenState {
  final MatrixResponse response;

  EigenSuccess({required this.response});
}

final class EigenFailure extends EigenState {
  final String message;

  EigenFailure({required this.message});
}
