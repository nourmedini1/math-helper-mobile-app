import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/linear_systems/data/models/linear_system_request.dart';
import 'package:math_helper/features/linear_systems/data/models/linear_system_response.dart';
import 'package:math_helper/features/linear_systems/domain/usecases/solve_linear_system_usecase.dart';
import 'package:meta/meta.dart';

part 'solve_linear_system_event.dart';
part 'solve_linear_system_state.dart';

class SolveLinearSystemBloc
    extends Bloc<SolveLinearSystemEvent, SolveLinearSystemState> {
  final SolveLinearSystemUsecase solveLinearSystemUsecase;
  SolveLinearSystemBloc({required this.solveLinearSystemUsecase})
      : super(SolveLinearSystemInitial()) {
    on<SolveLinearSystemEvent>((event, emit) async {
      if (event is SolveLinearSystemReset) {
        emit(SolveLinearSystemInitial());
      }
      if (event is SolveLinearSystemRequested) {
        emit(SolveLinearSystemLoading());
        final result = await solveLinearSystemUsecase(event.request);
        result.fold(
          (failure) => emit(SolveLinearSystemFailure(message: failure.message)),
          (response) {
            ic<LocalStorageService>().registerOperation(Operation(
                title: "Linear Equations",
                results: [response.linearSystem, response.result!],
                doneAt: DateTime.now(),
                label: Labels.LINEAR_EQUATIONS_LABEL));
            emit(SolveLinearSystemSuccess(response: response));
          },
        );
      }
    }, transformer: droppable());
  }
}
