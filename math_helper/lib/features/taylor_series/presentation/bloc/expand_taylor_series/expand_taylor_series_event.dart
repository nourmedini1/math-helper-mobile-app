part of 'expand_taylor_series_bloc.dart';

@immutable
sealed class ExpandTaylorSeriesEvent extends Equatable {
  const ExpandTaylorSeriesEvent();
}

final class ExpandTaylorSeriesRequested extends ExpandTaylorSeriesEvent {
  final TaylorSeriesRequest request;
  const ExpandTaylorSeriesRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class ExpandTaylorSeriesReset extends ExpandTaylorSeriesEvent {
  const ExpandTaylorSeriesReset();
  @override
  List<Object> get props => [];
}
