import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_request.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_response.dart';
import 'package:math_helper/features/complex/domain/usecases/complex_substraction_usecase.dart';
import 'package:meta/meta.dart';

part 'complex_substraction_event.dart';
part 'complex_substraction_state.dart';

class ComplexSubstractionBloc
    extends Bloc<ComplexSubstractionEvent, ComplexSubstractionState> {
  final ComplexSubstractionUsecase complexSubstractionUsecase;
  ComplexSubstractionBloc({required this.complexSubstractionUsecase})
      : super(ComplexSubstractionInitial()) {
    on<ComplexSubstractionEvent>((event, emit) async {
      emit(ComplexSubstractionLoading());
      final response = await complexSubstractionUsecase(event.request);
      response.fold(
        (failure) => emit(ComplexSubstractionFailure(message: failure.message)),
        (success) =>
            emit(ComplexSubstractionOperationSuccess(response: success)),
      );
    }, transformer: droppable());
  }
}
