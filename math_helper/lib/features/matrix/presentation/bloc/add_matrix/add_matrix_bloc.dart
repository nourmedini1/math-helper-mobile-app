import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/data/models/matrix_response.dart';
import 'package:math_helper/features/matrix/domain/usecases/add_matrix_usecase.dart';
import 'package:meta/meta.dart';

part 'add_matrix_event.dart';
part 'add_matrix_state.dart';

class AddMatrixBloc extends Bloc<AddMatrixEvent, AddMatrixState> {
  final AddMatrixUsecase addMatrixUsecase;
  AddMatrixBloc({required this.addMatrixUsecase}) : super(AddMatrixInitial()) {
    on<AddMatrixEvent>((event, emit) async {
      if (event is AddMatrixReset) {
        emit(AddMatrixInitial());
      }
      if (event is AddMatrixRequested) {
        emit(AddMatrixLoading());
        final result = await addMatrixUsecase(event.request);
        result
            .fold((failure) => emit(AddMatrixFailure(message: failure.message)),
                (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Add Matrix",
              results: [response.matrixA!, response.matrixB!, response.matrix!],
              doneAt: DateTime.now(),
              label: Labels.MATRIX_OPERATIONS_LABEL));
          emit(AddMatrixSuccess(response: response));
        });
      }
    }, transformer: droppable());
  }
}
