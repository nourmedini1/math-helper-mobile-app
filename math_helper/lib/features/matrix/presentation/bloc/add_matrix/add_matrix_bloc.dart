import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/data/models/matrix_response.dart';
import 'package:math_helper/features/matrix/domain/usecases/add_matrix_usecase.dart';
import 'package:meta/meta.dart';

part 'add_matrix_event.dart';
part 'add_matrix_state.dart';

class AddMatrixBloc extends Bloc<AddMatrixEvent, AddMatrixState> {
  final AddMatrixUsecase addMatrixUsecase;
  AddMatrixBloc({required this.addMatrixUsecase}) : super(AddMatrixInitial()) {
    on<AddMatrixEvent>((event, emit) async {
      if (event is AddMatrixReset) {
        emit(AddMatrixInitial());
      }
      if (event is AddMatrixRequested) {
        emit(AddMatrixLoading());
        final result = await addMatrixUsecase(event.request);
        result.fold(
            (failure) => emit(AddMatrixFailure(message: failure.message)),
            (response) => emit(AddMatrixSuccess(response: response)));
      }
    }, transformer: droppable());
  }
}
