import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_request.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_response.dart';
import 'package:math_helper/features/complex/domain/usecases/complex_multiplication_usecase.dart';
import 'package:meta/meta.dart';

part 'complex_multiplication_event.dart';
part 'complex_multiplication_state.dart';

class ComplexMultiplicationBloc
    extends Bloc<ComplexMultiplicationEvent, ComplexMultiplicationState> {
  final ComplexMultiplicationUsecase complexMultiplicationUsecase;
  ComplexMultiplicationBloc({required this.complexMultiplicationUsecase})
      : super(ComplexMultiplicationInitial()) {
    on<ComplexMultiplicationEvent>((event, emit) async {
      if (event is ComplexMultiplicationReset) {
        emit(ComplexMultiplicationInitial());
      }
      if (event is ComplexMultiplicationRequested) {
        emit(ComplexMultiplicationLoading());
        final response = await complexMultiplicationUsecase(event.request);
        response.fold(
          (failure) =>
              emit(ComplexMultiplicationFailure(message: failure.message)),
          (success) => emit(ComplexMultiplicationSuccess(response: success)),
        );
      }
    }, transformer: droppable());
  }
}
