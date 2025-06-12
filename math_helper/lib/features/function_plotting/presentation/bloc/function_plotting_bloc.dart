import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_request.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_response.dart';
import 'package:math_helper/features/function_plotting/domain/usecases/function_plotting_usecase.dart';
import 'package:meta/meta.dart';

part 'function_plotting_event.dart';
part 'function_plotting_state.dart';

class FunctionPlottingBloc
    extends Bloc<FunctionPlottingEvent, FunctionPlottingState>  {
  final FunctionPlottingUsecase functionPlottingUsecase;
  FunctionPlottingBloc({required this.functionPlottingUsecase})
      : super(FunctionPlottingInitial()) {
    on<FunctionPlottingEvent>((event, emit) async{
      if (event is PlotFunctionReset) {
        emit(FunctionPlottingInitial());
      } else if (event is PlotFunctionRequested) {
        emit(FunctionPlottingLoading());
        final result = await functionPlottingUsecase.call(event.request);
        result.fold(
          (failure) => emit(FunctionPlottingFailure(message: failure.message)),
          (response) {
           emit(FunctionPlottingSuccess(plotResponse: response));
          },
        );
        
      }
    }, transformer: droppable());
  }
}
