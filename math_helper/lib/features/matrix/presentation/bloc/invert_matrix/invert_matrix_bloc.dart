import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/data/models/matrix_response.dart';
import 'package:math_helper/features/matrix/domain/usecases/invert_matrix_usecase.dart';
import 'package:meta/meta.dart';

part 'invert_matrix_event.dart';
part 'invert_matrix_state.dart';

class InvertMatrixBloc extends Bloc<InvertMatrixEvent, InvertMatrixState> {
  final InvertMatrixUsecase invertMatrixUsecase;
  InvertMatrixBloc({required this.invertMatrixUsecase})
      : super(InvertMatrixInitial()) {
    on<InvertMatrixEvent>((event, emit) async {
      if (event is InvertMatrixRequested) {
        emit(InvertMatrixLoading());
        final result = await invertMatrixUsecase(event.request);
        result.fold(
          (failure) => emit(InvertMatrixFailure(message: failure.message)),
          (response) {
            ic<LocalStorageService>().registerOperation(Operation(
                title: "Invert Matrix",
                results: [response.matrixA!, response.matrix!],
                doneAt: DateTime.now(),
                label: Labels.INVERT_MATRIX_LABEL));
            emit(InvertMatrixSuccess(response: response));
          },
        );
      } else if (event is InvertMatrixReset) {
        emit(InvertMatrixInitial());
      }
    }, transformer: droppable());
  }
}
