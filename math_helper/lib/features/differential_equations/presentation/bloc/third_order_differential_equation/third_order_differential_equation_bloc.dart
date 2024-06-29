import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_request.dart';
import 'package:math_helper/features/differential_equations/data/models/differential_equation_response.dart';
import 'package:math_helper/features/differential_equations/domain/usecases/third_order_differential_equation.dart';
import 'package:meta/meta.dart';

part 'third_order_differential_equation_event.dart';
part 'third_order_differential_equation_state.dart';

class ThirdOrderDifferentialEquationBloc extends Bloc<
    ThirdOrderDifferentialEquationEvent, ThirdOrderDifferentialEquationState> {
  final ThirdOrderDifferentialEquation thirdOrderDifferentialEquation;
  ThirdOrderDifferentialEquationBloc(
      {required this.thirdOrderDifferentialEquation})
      : super(ThirdOrderDifferentialEquationInitial()) {
    on<ThirdOrderDifferentialEquationEvent>((event, emit) async {
      emit(ThirdOrderDifferentialEquationLoading());
      final result = await thirdOrderDifferentialEquation(event.request);
      result.fold(
        (failure) => emit(
            ThirdOrderDifferentialEquationFailure(message: failure.message)),
        (response) =>
            emit(ThirdOrderDifferentialEquationSuccess(response: response)),
      );
    }, transformer: droppable());
  }
}
