import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
      emit(SolveLinearSystemLoading());
      final result = await solveLinearSystemUsecase(event.request);
      result.fold(
        (failure) => emit(SolveLinearSystemFailure(message: failure.message)),
        (response) => emit(SolveLinearSystemSuccess(response: response)),
      );
    }, transformer: droppable());
  }
}
