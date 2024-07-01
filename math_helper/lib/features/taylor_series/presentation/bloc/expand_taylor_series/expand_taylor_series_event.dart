part of 'expand_taylor_series_bloc.dart';

@immutable
sealed class ExpandTaylorSeriesEvent {
  final TaylorSeriesRequest request;
  const ExpandTaylorSeriesEvent({required this.request});
}
