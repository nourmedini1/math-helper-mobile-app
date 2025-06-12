part of 'function_plotting_bloc.dart';

@immutable
sealed class FunctionPlottingState {}

final class FunctionPlottingInitial extends FunctionPlottingState {}

final class FunctionPlottingLoading extends FunctionPlottingState {}

final class FunctionPlottingSuccess extends FunctionPlottingState {
  final PlotResponse plotResponse;

  FunctionPlottingSuccess({
    required this.plotResponse,
  });
}

final class FunctionPlottingFailure extends FunctionPlottingState {
  final String message;

  FunctionPlottingFailure({
    required this.message,
  });
}
