import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_request.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_response.dart';
import 'package:math_helper/features/derivatives/domain/usecases/symbolic_derivative_usecase.dart';
import 'package:meta/meta.dart';

part 'symbolic_derivative_event.dart';
part 'symbolic_derivative_state.dart';

class SymbolicDerivativeBloc
    extends Bloc<SymbolicDerivativeEvent, SymbolicDerivativeState> {
  final SymbolicDerivativeUsecase symbolicDerivativeUsecase;
  SymbolicDerivativeBloc({required this.symbolicDerivativeUsecase})
      : super(SymbolicDerivativeInitial()) {
    on<SymbolicDerivativeEvent>((event, emit) async {
      if (event is SymbolicDerivativeReset) {
        emit(SymbolicDerivativeInitial());
      } else if (event is SymbolicDerivativeRequested) {
        emit(SymbolicDerivativeLoading());
        final result = await symbolicDerivativeUsecase(event.request);
        result.fold(
            (failure) =>
                emit(SymbolicDerivativeFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Symbolic Derivative",
              results: [response.derivative, response.result.toString()],
              doneAt: DateTime.now(),
              label: Labels.DERIVATIVE_LABEL));
          emit(SymbolicDerivativeSuccess(response: response));
        });
      }
    }, transformer: droppable());
  }
}
