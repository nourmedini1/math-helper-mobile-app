import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_request.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_response.dart';
import 'package:math_helper/features/differential_equations/domain/usecases/second_order_differential_equation_usecase.dart';
import 'package:meta/meta.dart';

part 'second_order_differential_equation_event.dart';
part 'second_order_differential_equation_state.dart';

class SecondOrderDifferentialEquationBloc extends Bloc<
    SecondOrderDifferentialEquationEvent,
    SecondOrderDifferentialEquationState> {
  final SecondOrderDifferentialEquationUsecase
      secondOrderDifferentialEquationUsecase;
  SecondOrderDifferentialEquationBloc({
    required this.secondOrderDifferentialEquationUsecase,
  }) : super(SecondOrderDifferentialEquationInitial()) {
    on<SecondOrderDifferentialEquationEvent>((event, emit) async {
      emit(SecondOrderDifferentialEquationLoading());
      final result =
          await secondOrderDifferentialEquationUsecase(event.request);
      result.fold(
        (failure) => emit(
            SecondOrderDifferentialEquationFailure(message: failure.message)),
        (response) =>
            emit(SecondOrderDifferentialEquationSuccess(response: response)),
      );
    }, transformer: droppable());
  }
}
