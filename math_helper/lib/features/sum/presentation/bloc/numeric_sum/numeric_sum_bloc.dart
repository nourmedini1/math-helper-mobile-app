import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/sum/data/models/sum_request.dart';
import 'package:math_helper/features/sum/data/models/sum_response.dart';
import 'package:math_helper/features/sum/domain/usecases/numeric_sum_usecase.dart';
import 'package:meta/meta.dart';

part 'numeric_sum_event.dart';
part 'numeric_sum_state.dart';

class NumericSumBloc extends Bloc<NumericSumEvent, NumericSumState> {
  final NumericSumUsecase numericSumUsecase;
  NumericSumBloc({required this.numericSumUsecase})
      : super(NumericSumInitial()) {
    on<NumericSumEvent>((event, emit) async {
      if (event is NumericSumReset) {
        emit(NumericSumInitial());
      }
      if (event is NumericSumRequested) {
        emit(NumericSumLoading());
        final result = await numericSumUsecase(event.request);
        result.fold(
          (failure) => emit(NumericSumFailure(message: failure.message)),
          (response) {
            ic<LocalStorageService>().registerOperation(Operation(
                title: "Numeric Sum",
                results: [response.summation, response.result],
                doneAt: DateTime.now(),
                label: Labels.SUMMATION_LABEL));
            emit(NumericSumSuccess(response: response));
          },
        );
      }
    }, transformer: droppable());
  }
}
