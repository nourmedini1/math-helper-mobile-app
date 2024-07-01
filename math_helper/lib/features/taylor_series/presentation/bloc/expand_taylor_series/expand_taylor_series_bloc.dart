import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/taylor_series/data/models/taylor_series_request.dart';
import 'package:math_helper/features/taylor_series/data/models/taylor_series_response.dart';
import 'package:math_helper/features/taylor_series/domain/usecases/expand_taylor_series_usecase.dart';
import 'package:meta/meta.dart';

part 'expand_taylor_series_event.dart';
part 'expand_taylor_series_state.dart';

class ExpandTaylorSeriesBloc
    extends Bloc<ExpandTaylorSeriesEvent, ExpandTaylorSeriesState> {
  final ExpandTaylorSeriesUsecase taylorSeriesUsecase;
  ExpandTaylorSeriesBloc({required this.taylorSeriesUsecase})
      : super(ExpandTaylorSeriesInitial()) {
    on<ExpandTaylorSeriesEvent>((event, emit) async {
      emit(ExpandTaylorSeriesLoading());
      final result = await taylorSeriesUsecase(event.request);
      result.fold(
        (failure) => emit(ExpandTaylorSeriesFailure(message: failure.message)),
        (response) => emit(ExpandTaylorSeriesSuccess(response: response)),
      );
    }, transformer: droppable());
  }
}
