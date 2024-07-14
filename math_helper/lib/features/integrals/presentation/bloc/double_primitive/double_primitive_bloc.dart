import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';
import 'package:math_helper/features/integrals/domain/usecases/double_primitive_usecase.dart';
import 'package:meta/meta.dart';

part 'double_primitive_event.dart';
part 'double_primitive_state.dart';

class DoublePrimitiveBloc
    extends Bloc<DoublePrimitiveEvent, DoublePrimitiveState> {
  final DoublePrimitiveUsecase doublePrimitiveUsecase;
  DoublePrimitiveBloc({required this.doublePrimitiveUsecase})
      : super(DoublePrimitiveInitial()) {
    on<DoublePrimitiveEvent>((event, emit) {
      if (event is DoublePrimitiveReset) {
        emit(DoublePrimitiveInitial());
      } else if (event is DoublePrimitiveRequested) {
        emit(DoublePrimitiveLoading());
        doublePrimitiveUsecase(event.request).then((result) {
          result.fold(
            (failure) => emit(DoublePrimitiveFailure(message: failure.message)),
            (response) =>
                emit(DoublePrimitiveSuccess(integralResponse: response)),
          );
        });
      }
    }, transformer: droppable());
  }
}
