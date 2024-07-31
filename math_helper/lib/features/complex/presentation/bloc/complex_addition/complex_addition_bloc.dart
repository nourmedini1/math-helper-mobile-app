import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_request.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_response.dart';
import 'package:math_helper/features/complex/domain/usecases/complex_addition_usecase.dart';
import 'package:meta/meta.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'complex_addition_event.dart';
part 'complex_addition_state.dart';

class ComplexAdditionBloc
    extends Bloc<ComplexAdditionEvent, ComplexAdditionState> {
  final ComplexAdditionUsecase complexAdditionUsecase;
  ComplexAdditionBloc({required this.complexAdditionUsecase})
      : super(ComplexAdditionInitial()) {
    on<ComplexAdditionEvent>((event, emit) async {
      if (event is ComplexAdditionReset) {
        emit(ComplexAdditionInitial());
      } else {
        if (event is ComplexAdditionRequested) {
          emit(ComplexAdditionLoading());
          final response = await complexAdditionUsecase.call(event.request);
          response.fold(
              (failure) =>
                  emit(ComplexAdditionFailure(message: failure.message)),
              (response) {
            ic<LocalStorageService>().registerOperation(Operation(
                title: "Complex Addition",
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
            emit(ComplexAdditionSuccess(response: response));
          });
        }
      }
    }, transformer: droppable());
  }
}
