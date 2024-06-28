import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_request.dart';
import 'package:math_helper/features/derivatives/data/models/derivative_response.dart';
import 'package:math_helper/features/derivatives/domain/usecases/symbolic_derivative_usecase.dart';
import 'package:meta/meta.dart';

part 'symbolic_derivative_event.dart';
part 'symbolic_derivative_state.dart';

class SymbolicDerivativeBloc
    extends Bloc<SymbolicDerivativeEvent, SymbolicDerivativeState> {
  final SymbolicDerivativeUsecase symbolicDerivativeUsecase;
  SymbolicDerivativeBloc({required this.symbolicDerivativeUsecase})
      : super(SymbolicDerivativeInitial()) {
    on<SymbolicDerivativeEvent>((event, emit) async {
      emit(SymbolicDerivativeLoading());
      final result = await symbolicDerivativeUsecase(event.request);
      result.fold(
        (failure) => emit(SymbolicDerivativeFailure(message: failure.message)),
        (response) => emit(SymbolicDerivativeSuccess(response: response)),
      );
    }, transformer: droppable());
  }
}
