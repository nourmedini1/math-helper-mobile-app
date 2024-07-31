import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/data/models/matrix_response.dart';
import 'package:math_helper/features/matrix/domain/usecases/get_eigen_usecase.dart';
import 'package:meta/meta.dart';

part 'eigen_event.dart';
part 'eigen_state.dart';

class EigenBloc extends Bloc<EigenEvent, EigenState> {
  final GetEigenUsecase getEigenUsecase;
  EigenBloc({required this.getEigenUsecase}) : super(EigenInitial()) {
    on<EigenEvent>((event, emit) async {
      if (event is EigenReset) {
        emit(EigenInitial());
      }
      if (event is EigenRequested) {
        emit(EigenLoading());
        final result = await getEigenUsecase(event.request);
        result.fold((failure) => emit(EigenFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Matrix Eigen",
              results: [
                response.matrixA!,
                response.eigenValue!,
                response.eigenVector!
              ],
              doneAt: DateTime.now(),
              label: Labels.EIGEN_LABEL));
          emit(EigenSuccess(response: response));
        });
      }
    }, transformer: droppable());
  }
}
