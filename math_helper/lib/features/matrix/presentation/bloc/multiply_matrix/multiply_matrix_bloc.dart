import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/data/models/matrix_response.dart';
import 'package:math_helper/features/matrix/domain/usecases/multiply_matrix_usecase.dart';
import 'package:meta/meta.dart';

part 'multiply_matrix_event.dart';
part 'multiply_matrix_state.dart';

class MultiplyMatrixBloc
    extends Bloc<MultiplyMatrixEvent, MultiplyMatrixState> {
  final MultiplyMatrixUsecase multiplyMatrixUsecase;
  MultiplyMatrixBloc({required this.multiplyMatrixUsecase})
      : super(MultiplyMatrixInitial()) {
    on<MultiplyMatrixEvent>((event, emit) async {
      emit(MultiplyMatrixLoading());
      final result = await multiplyMatrixUsecase(event.request);
      result.fold(
          (failure) => emit(MultiplyMatrixFailure(message: failure.message)),
          (response) => emit(MultiplyMatrixSuccess(response: response)));
    }, transformer: droppable());
  }
}
