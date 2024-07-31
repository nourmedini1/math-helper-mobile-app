import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';
import 'package:math_helper/features/integrals/domain/usecases/single_integral_usecase.dart';
import 'package:meta/meta.dart';

part 'single_integral_event.dart';
part 'single_integral_state.dart';

class SingleIntegralBloc
    extends Bloc<SingleIntegralEvent, SingleIntegralState> {
  final SingleIntegralUsecase singleIntegralUsecase;
  SingleIntegralBloc({required this.singleIntegralUsecase})
      : super(SingleIntegralInitial()) {
    on<SingleIntegralEvent>((event, emit) async {
      if (event is SingleIntegralReset) {
        emit(SingleIntegralInitial());
      } else if (event is SingleIntegralRequested) {
        emit(SingleIntegralLoading());
        final result = await singleIntegralUsecase(event.request);
        result.fold(
            (failure) => emit(SingleIntegralFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Single Integral",
              results: [response.integral, response.result],
              doneAt: DateTime.now(),
              label: Labels.DEFINITE_INTEGRAL_LABEL));
          emit(SingleIntegralSuccess(integralResponse: response));
        });
      }
    }, transformer: droppable());
  }
}
