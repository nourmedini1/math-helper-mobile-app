import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
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
      if (event is ExpandTaylorSeriesReset) {
        emit(ExpandTaylorSeriesInitial());
      }
      if (event is ExpandTaylorSeriesRequested) {
        emit(ExpandTaylorSeriesLoading());
        final result = await taylorSeriesUsecase(event.request);
        result.fold(
            (failure) =>
                emit(ExpandTaylorSeriesFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Taylor Series",
              results: [response.expression, response.result],
              doneAt: DateTime.now(),
              label: Labels.TAYLOR_SERIES_LABEL));
          emit(ExpandTaylorSeriesSuccess(response: response));
        });
      }
    }, transformer: droppable());
  }
}
