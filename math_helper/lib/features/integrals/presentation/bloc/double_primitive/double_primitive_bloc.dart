import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';
import 'package:math_helper/features/integrals/domain/usecases/double_primitive_usecase.dart';
import 'package:meta/meta.dart';

part 'double_primitive_event.dart';
part 'double_primitive_state.dart';

class DoublePrimitiveBloc
    extends Bloc<DoublePrimitiveEvent, DoublePrimitiveState> {
  final DoublePrimitiveUsecase doublePrimitiveUsecase;
  DoublePrimitiveBloc({required this.doublePrimitiveUsecase})
      : super(DoublePrimitiveInitial()) {
    on<DoublePrimitiveEvent>((event, emit) async {
      if (event is DoublePrimitiveReset) {
        emit(DoublePrimitiveInitial());
      } else if (event is DoublePrimitiveRequested) {
        emit(DoublePrimitiveLoading());
        final result = await doublePrimitiveUsecase(event.request);
        result.fold(
            (failure) => emit(DoublePrimitiveFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Double Primitive",
              results: [response.integral, response.result],
              doneAt: DateTime.now(),
              label: Labels.INDEFINITE_INTEGRAL_LABEL));
          emit(DoublePrimitiveSuccess(integralResponse: response));
        });
      }
    }, transformer: droppable());
  }
}
