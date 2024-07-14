part of 'determinant_bloc.dart';

@immutable
sealed class DeterminantEvent extends Equatable {
  const DeterminantEvent();
}

final class DeterminantRequested extends DeterminantEvent {
  final MatrixRequest request;
  const DeterminantRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class DeterminantReset extends DeterminantEvent {
  const DeterminantReset();
  @override
  List<Object> get props => [];
}
