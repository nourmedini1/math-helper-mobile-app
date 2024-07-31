import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_request.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_response.dart';
import 'package:math_helper/features/complex/domain/usecases/complex_multiplication_usecase.dart';
import 'package:meta/meta.dart';

part 'complex_multiplication_event.dart';
part 'complex_multiplication_state.dart';

class ComplexMultiplicationBloc
    extends Bloc<ComplexMultiplicationEvent, ComplexMultiplicationState> {
  final ComplexMultiplicationUsecase complexMultiplicationUsecase;
  ComplexMultiplicationBloc({required this.complexMultiplicationUsecase})
      : super(ComplexMultiplicationInitial()) {
    on<ComplexMultiplicationEvent>((event, emit) async {
      if (event is ComplexMultiplicationReset) {
        emit(ComplexMultiplicationInitial());
      }
      if (event is ComplexMultiplicationRequested) {
        emit(ComplexMultiplicationLoading());
        final response = await complexMultiplicationUsecase(event.request);
        response.fold(
            (failure) =>
                emit(ComplexMultiplicationFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Complex Multiplication",
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
          emit(ComplexMultiplicationSuccess(response: response));
        });
      }
    }, transformer: droppable());
  }
}
