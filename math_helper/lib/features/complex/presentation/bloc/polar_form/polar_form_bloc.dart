import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/features/complex/data/models/polar_form_request.dart';
import 'package:math_helper/features/complex/data/models/polar_form_response.dart';
import 'package:math_helper/features/complex/domain/usecases/polar_form_usecase.dart';
import 'package:meta/meta.dart';

part 'polar_form_event.dart';
part 'polar_form_state.dart';

class PolarFormBloc extends Bloc<PolarFormEvent, PolarFormState> {
  final PolarFormUsecase polarFormUsecase;
  PolarFormBloc({required this.polarFormUsecase}) : super(PolarFormInitial()) {
    on<PolarFormEvent>((event, emit) async {
      if (event is PolarFormReset) {
        emit(PolarFormInitial());
      }
      if (event is PolarFormRequested) {
        emit(PolarFormLoading());
        final response = await polarFormUsecase(event.request);
        response.fold(
          (failure) => emit(PolarFormFailure(message: failure.message)),
          (success) => emit(PolarFormOperationSuccess(response: success)),
        );
      }
    }, transformer: droppable());
  }
}
