import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';
import 'package:math_helper/features/integrals/domain/usecases/double_integral_usecase.dart';
import 'package:meta/meta.dart';

part 'double_integral_event.dart';
part 'double_integral_state.dart';

class DoubleIntegralBloc
    extends Bloc<DoubleIntegralEvent, DoubleIntegralState> {
  final DoubleIntegralUsecase doubleIntegralUsecase;
  DoubleIntegralBloc({required this.doubleIntegralUsecase})
      : super(DoubleIntegralInitial()) {
    on<DoubleIntegralEvent>((event, emit) async {
      if (event is DoubleIntegralReset) {
        emit(DoubleIntegralInitial());
      } else if (event is DoubleIntegralRequested) {
        emit(DoubleIntegralLoading());
        final result = await doubleIntegralUsecase(event.request);
        result.fold(
            (failure) => emit(DoubleIntegralFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Double Integral",
              results: [response.integral, response.result],
              doneAt: DateTime.now(),
              label: Labels.DEFINITE_INTEGRAL_LABEL));
          emit(DoubleIntegralSuccess(integralResponse: response));
        });
      }
    }, transformer: droppable());
  }
}
