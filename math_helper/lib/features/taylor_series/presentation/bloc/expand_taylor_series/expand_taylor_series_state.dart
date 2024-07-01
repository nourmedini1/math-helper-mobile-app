part of 'expand_taylor_series_bloc.dart';

@immutable
sealed class ExpandTaylorSeriesState {}

final class ExpandTaylorSeriesInitial extends ExpandTaylorSeriesState {}

final class ExpandTaylorSeriesLoading extends ExpandTaylorSeriesState {}

final class ExpandTaylorSeriesSuccess extends ExpandTaylorSeriesState {
  final TaylorSeriesResponse response;
  ExpandTaylorSeriesSuccess({required this.response});
}

final class ExpandTaylorSeriesFailure extends ExpandTaylorSeriesState {
  final String message;
  ExpandTaylorSeriesFailure({required this.message});
}
