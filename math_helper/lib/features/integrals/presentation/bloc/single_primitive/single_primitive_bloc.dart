import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';
import 'package:math_helper/features/integrals/domain/usecases/single_primitive_usecase.dart';
import 'package:meta/meta.dart';

part 'single_primitive_event.dart';
part 'single_primitive_state.dart';

class SinglePrimitiveBloc
    extends Bloc<SinglePrimitiveEvent, SinglePrimitiveState> {
  final SinglePrimitiveUsecase singlePrimitiveUsecase;
  SinglePrimitiveBloc({required this.singlePrimitiveUsecase})
      : super(SinglePrimitiveInitial()) {
    on<SinglePrimitiveEvent>((event, emit) async {
      emit(SinglePrimitiveLoading());
      final result = await singlePrimitiveUsecase(event.request);
      result.fold(
        (failure) => emit(SinglePrimitiveFailure(message: failure.message)),
        (response) => emit(SinglePrimitiveSuccess(integralResponse: response)),
      );
    }, transformer: droppable());
  }
}
