part of 'eigen_bloc.dart';

@immutable
sealed class EigenEvent extends Equatable {
  const EigenEvent();
}

final class EigenRequested extends EigenEvent {
  final MatrixRequest request;
  const EigenRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class EigenReset extends EigenEvent {
  const EigenReset();
  @override
  List<Object> get props => [];
}
