import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/data/models/matrix_response.dart';
import 'package:math_helper/features/matrix/domain/usecases/get_determinant_usecase.dart';
import 'package:meta/meta.dart';

part 'determinant_event.dart';
part 'determinant_state.dart';

class DeterminantBloc extends Bloc<DeterminantEvent, DeterminantState> {
  final GetDeterminantUsecase getDeterminantUsecase;
  DeterminantBloc({required this.getDeterminantUsecase})
      : super(DeterminantInitial()) {
    on<DeterminantEvent>((event, emit) async {
      if (event is DeterminantReset) {
        emit(DeterminantInitial());
      }
      if (event is DeterminantRequested) {
        emit(DeterminantLoading());
        final result = await getDeterminantUsecase(event.request);
        result.fold(
            (failure) => emit(DeterminantFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Matrix Determinant",
              results: [response.matrixA!, response.determinant!],
              doneAt: DateTime.now(),
              label: Labels.DETERMINANT_LABEL));
          emit(DeterminantSuccess(response: response));
        });
      }
    }, transformer: droppable());
  }
}
