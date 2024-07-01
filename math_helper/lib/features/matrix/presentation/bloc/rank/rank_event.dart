part of 'rank_bloc.dart';

@immutable
sealed class RankEvent {
  final MatrixRequest request;

  const RankEvent({required this.request});
}
