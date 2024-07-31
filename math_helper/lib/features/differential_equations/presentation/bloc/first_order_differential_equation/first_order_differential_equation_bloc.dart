import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_request.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_response.dart';
import 'package:math_helper/features/differential_equations/domain/usecases/first_order_differential_equation_usecase.dart';
import 'package:meta/meta.dart';

part 'first_order_differential_equation_event.dart';
part 'first_order_differential_equation_state.dart';

class FirstOrderDifferentialEquationBloc extends Bloc<
    FirstOrderDifferentialEquationEvent, FirstOrderDifferentialEquationState> {
  final FirstOrderDifferentialEquationUsecase
      firstOrderDifferentialEquationUsecase;
  FirstOrderDifferentialEquationBloc(
      {required this.firstOrderDifferentialEquationUsecase})
      : super(FirstOrderDifferentialEquationInitial()) {
    on<FirstOrderDifferentialEquationEvent>((event, emit) async {
      if (event is FirstOrderDifferentialEquationReset) {
        emit(FirstOrderDifferentialEquationInitial());
      } else if (event is FirstOrderDifferentialEquationRequested) {
        emit(FirstOrderDifferentialEquationLoading());
        final result =
            await firstOrderDifferentialEquationUsecase(event.request);
        result.fold(
            (failure) => emit(FirstOrderDifferentialEquationFailure(
                message: failure.message)), (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "First Order Differential Equation",
              results: [response.equation, response.solution],
              doneAt: DateTime.now(),
              label: Labels.DIFFERENTIAL_EQUATIONS_LABEL));
          emit(FirstOrderDifferentialEquationSuccess(response: response));
        });
      }
    }, transformer: droppable());
  }
}
