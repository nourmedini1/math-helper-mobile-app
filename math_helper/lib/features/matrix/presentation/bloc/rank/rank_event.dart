part of 'rank_bloc.dart';

@immutable
sealed class RankEvent extends Equatable {
  const RankEvent();
}

final class RankRequested extends RankEvent {
  final MatrixRequest request;
  const RankRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class RankReset extends RankEvent {
  const RankReset();
  @override
  List<Object> get props => [];
}
