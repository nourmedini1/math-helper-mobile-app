import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_request.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_response.dart';
import 'package:math_helper/features/complex/domain/usecases/complex_substraction_usecase.dart';
import 'package:meta/meta.dart';

part 'complex_substraction_event.dart';
part 'complex_substraction_state.dart';

class ComplexSubstractionBloc
    extends Bloc<ComplexSubstractionEvent, ComplexSubstractionState> {
  final ComplexSubstractionUsecase complexSubstractionUsecase;
  ComplexSubstractionBloc({required this.complexSubstractionUsecase})
      : super(ComplexSubstractionInitial()) {
    on<ComplexSubstractionEvent>((event, emit) async {
      if (event is ComplexSubstractionReset) {
        emit(ComplexSubstractionInitial());
      }
      if (event is ComplexSubstractionRequested) {
        emit(ComplexSubstractionLoading());
        final response = await complexSubstractionUsecase(event.request);
        response.fold(
            (failure) =>
                emit(ComplexSubstractionFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Complex Substraction",
              results: [
                response.z1,
                response.polarZ1,
                response.z2,
                response.polarZ2,
                response.algebraicResult,
                response.polarResult
              ],
              doneAt: DateTime.now(),
              label: Labels.COMPLEX_OPERATIONS_LABEL));
          emit(ComplexSubstractionSuccess(response: response));
        });
      }
    }, transformer: droppable());
  }
}
