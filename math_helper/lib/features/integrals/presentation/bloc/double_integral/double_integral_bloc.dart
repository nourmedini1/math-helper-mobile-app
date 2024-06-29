import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';
import 'package:math_helper/features/integrals/domain/usecases/double_integral_usecase.dart';
import 'package:meta/meta.dart';

part 'double_integral_event.dart';
part 'double_integral_state.dart';

class DoubleIntegralBloc
    extends Bloc<DoubleIntegralEvent, DoubleIntegralState> {
  final DoubleIntegralUsecase doubleIntegralUsecase;
  DoubleIntegralBloc({required this.doubleIntegralUsecase})
      : super(DoubleIntegralInitial()) {
    on<DoubleIntegralEvent>((event, emit) async {
      emit(DoubleIntegralLoading());
      final result = await doubleIntegralUsecase(event.request);
      result.fold(
        (failure) => emit(DoubleIntegralFailure(message: failure.message)),
        (response) => emit(DoubleIntegralSuccess(integralResponse: response)),
      );
    }, transformer: droppable());
  }
}
