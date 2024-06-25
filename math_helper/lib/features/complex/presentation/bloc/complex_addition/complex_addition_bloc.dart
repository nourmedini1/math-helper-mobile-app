import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_request.dart';
import 'package:math_helper/features/complex/data/models/complex_operations_response.dart';
import 'package:math_helper/features/complex/domain/usecases/complex_addition_usecase.dart';
import 'package:meta/meta.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'complex_addition_event.dart';
part 'complex_addition_state.dart';

class ComplexAdditionBloc
    extends Bloc<ComplexAdditionEvent, ComplexAdditionState> {
  final ComplexAdditionUsecase complexAdditionUsecase;
  ComplexAdditionBloc({required this.complexAdditionUsecase})
      : super(ComplexAdditionInitial()) {
    on<ComplexAdditionEvent>((event, emit) async {
      final response = await complexAdditionUsecase.call(event.request);
      response.fold(
          (failure) => ComplexAdditionFailure(message: failure.message),
          (success) => ComplexAdditionOperationSuccess(response: success));
    }, transformer: droppable());
  }
}
