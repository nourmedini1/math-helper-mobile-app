import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';
import 'package:math_helper/features/integrals/domain/usecases/single_integral_usecase.dart';
import 'package:meta/meta.dart';

part 'single_integral_event.dart';
part 'single_integral_state.dart';

class SingleIntegralBloc
    extends Bloc<SingleIntegralEvent, SingleIntegralState> {
  final SingleIntegralUsecase singleIntegralUsecase;
  SingleIntegralBloc({required this.singleIntegralUsecase})
      : super(SingleIntegralInitial()) {
    on<SingleIntegralEvent>((event, emit) async {
      emit(SingleIntegralLoading());
      final result = await singleIntegralUsecase(event.request);
      result.fold(
        (failure) => emit(SingleIntegralFailure(message: failure.message)),
        (response) => emit(SingleIntegralSuccess(integralResponse: response)),
      );
    }, transformer: droppable());
  }
}
