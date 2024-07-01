import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/data/models/matrix_response.dart';
import 'package:math_helper/features/matrix/domain/usecases/get_determinant_usecase.dart';
import 'package:meta/meta.dart';

part 'determinant_event.dart';
part 'determinant_state.dart';

class DeterminantBloc extends Bloc<DeterminantEvent, DeterminantState> {
  final GetDeterminantUsecase getDeterminantUsecase;
  DeterminantBloc({required this.getDeterminantUsecase})
      : super(DeterminantInitial()) {
    on<DeterminantEvent>((event, emit) async {
      emit(DeterminantLoading());
      final result = await getDeterminantUsecase(event.request);
      result.fold(
          (failure) => emit(DeterminantFailure(message: failure.message)),
          (response) => emit(DeterminantSuccess(response: response)));
    }, transformer: droppable());
  }
}
