import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_request.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_response.dart';
import 'package:math_helper/features/derivatives/domain/usecases/numeric_derivative_usecase.dart';
import 'package:meta/meta.dart';

part 'numeric_derivative_event.dart';
part 'numeric_derivative_state.dart';

class NumericDerivativeBloc
    extends Bloc<NumericDerivativeEvent, NumericDerivativeState> {
  final NumericDerivativeUsecase numericDerivativeUsecase;
  NumericDerivativeBloc({required this.numericDerivativeUsecase})
      : super(NumericDerivativeInitial()) {
    on<NumericDerivativeEvent>((event, emit) async {
      if (event is NumericDerivativeReset) {
        emit(NumericDerivativeInitial());
      } else if (event is NumericDerivativeRequested) {
        emit(NumericDerivativeLoading());
        final result = await numericDerivativeUsecase(event.request);
        result.fold(
            (failure) =>
                emit(NumericDerivativeFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Numeric Derivative",
              results: [response.derivative, response.result.toString()],
              doneAt: DateTime.now(),
              label: Labels.DERIVATIVE_LABEL));
          emit(NumericDerivativeSuccess(response: response));
        });
      }
    }, transformer: droppable());
  }
}
