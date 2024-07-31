import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/sum/data/models/sum_request.dart';
import 'package:math_helper/features/sum/data/models/sum_response.dart';
import 'package:math_helper/features/sum/domain/usecases/symbolic_sum_usecase.dart';
import 'package:meta/meta.dart';

part 'symbolic_sum_event.dart';
part 'symbolic_sum_state.dart';

class SymbolicSumBloc extends Bloc<SymbolicSumEvent, SymbolicSumState> {
  final SymbolicSumUsecase symbolicSumUsecase;
  SymbolicSumBloc({required this.symbolicSumUsecase})
      : super(SymbolicSumInitial()) {
    on<SymbolicSumEvent>((event, emit) async {
      if (event is SymbolicSumReset) {
        emit(SymbolicSumInitial());
      } else if (event is SymbolicSumRequested) {
        emit(SymbolicSumLoading());
        final result = await symbolicSumUsecase(event.request);
        result.fold(
          (failure) => emit(SymbolicSumFailure(message: failure.message)),
          (response) {
            ic<LocalStorageService>().registerOperation(Operation(
                title: "Symbolic Sum",
                results: [response.summation, response.result],
                doneAt: DateTime.now(),
                label: Labels.SUMMATION_LABEL));
            emit(SymbolicSumSuccess(response: response));
          },
        );
      }
    }, transformer: droppable());
  }
}
