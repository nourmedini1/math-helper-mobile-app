part of 'taylor_series_fields_cubit.dart';

@immutable
sealed class TaylorSeriesFieldsState {}

final class TaylorSeriesFieldsMissing extends TaylorSeriesFieldsState {}
final class TaylorSeriesFieldsReady extends TaylorSeriesFieldsState {}
