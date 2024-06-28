import 'package:bloc/bloc.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_request.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_response.dart';
import 'package:math_helper/features/derivatives/domain/usecases/numeric_derivative_usecase.dart';
import 'package:meta/meta.dart';

part 'numeric_derivative_event.dart';
part 'numeric_derivative_state.dart';

class NumericDerivativeBloc
    extends Bloc<NumericDerivativeEvent, NumericDerivativeState> {
  final NumericDerivativeUsecase numericDerivativeUsecase;
  NumericDerivativeBloc({required this.numericDerivativeUsecase})
      : super(NumericDerivativeInitial()) {
    on<NumericDerivativeEvent>((event, emit) async {
      emit(NumericDerivativeLoading());
      final result = await numericDerivativeUsecase(event.request);
      result.fold(
        (failure) => emit(NumericDerivativeFailure(message: failure.message)),
        (response) => emit(NumericDerivativeSuccess(response: response)),
      );
    });
  }
}
