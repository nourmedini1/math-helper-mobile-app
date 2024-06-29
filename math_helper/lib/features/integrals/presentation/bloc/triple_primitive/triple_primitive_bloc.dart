import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';
import 'package:math_helper/features/integrals/domain/usecases/triple_primitive_usecase.dart';
import 'package:meta/meta.dart';

part 'triple_primitive_event.dart';
part 'triple_primitive_state.dart';

class TriplePrimitiveBloc
    extends Bloc<TriplePrimitiveEvent, TriplePrimitiveState> {
  final TriplePrimitiveUsecase triplePrimitiveUsecase;
  TriplePrimitiveBloc({required this.triplePrimitiveUsecase})
      : super(TriplePrimitiveInitial()) {
    on<TriplePrimitiveEvent>((event, emit) async {
      emit(TriplePrimitiveLoading());
      final result = await triplePrimitiveUsecase(event.request);
      result.fold(
        (failure) => emit(TriplePrimitiveFailure(message: failure.message)),
        (response) => emit(TriplePrimitiveSuccess(integralResponse: response)),
      );
    }, transformer: droppable());
  }
}
