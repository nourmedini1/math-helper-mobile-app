part of 'rank_bloc.dart';

@immutable
sealed class RankState {}

final class RankInitial extends RankState {}

final class RankLoading extends RankState {}

final class RankSuccess extends RankState {
  final MatrixResponse response;

  RankSuccess({required this.response});
}

final class RankFailure extends RankState {
  final String message;

  RankFailure({required this.message});
}
