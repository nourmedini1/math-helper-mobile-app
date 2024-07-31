import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';
import 'package:math_helper/features/integrals/domain/usecases/single_primitive_usecase.dart';
import 'package:meta/meta.dart';

part 'single_primitive_event.dart';
part 'single_primitive_state.dart';

class SinglePrimitiveBloc
    extends Bloc<SinglePrimitiveEvent, SinglePrimitiveState> {
  final SinglePrimitiveUsecase singlePrimitiveUsecase;
  SinglePrimitiveBloc({required this.singlePrimitiveUsecase})
      : super(SinglePrimitiveInitial()) {
    on<SinglePrimitiveEvent>((event, emit) async {
      if (event is SinglePrimitiveReset) {
        emit(SinglePrimitiveInitial());
      } else if (event is SinglePrimitiveRequested) {
        emit(SinglePrimitiveLoading());
        final result = await singlePrimitiveUsecase(event.request);
        result.fold(
            (failure) => emit(SinglePrimitiveFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Single Primitive",
              results: [response.integral, response.result],
              doneAt: DateTime.now(),
              label: Labels.INDEFINITE_INTEGRAL_LABEL));
          emit(SinglePrimitiveSuccess(integralResponse: response));
        });
      }
    }, transformer: droppable());
  }
}
