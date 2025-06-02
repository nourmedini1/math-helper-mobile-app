part of 'function_plotting_bloc.dart';

@immutable
sealed class FunctionPlottingEvent extends Equatable {}

final class PlotFunctionRequested extends FunctionPlottingEvent {
  final PlotRequest request;

  PlotFunctionRequested({required this.request});

  @override
  List<Object> get props => [request];
}

final class PlotFunctionReset extends FunctionPlottingEvent {
  @override
  List<Object> get props => [];
}
