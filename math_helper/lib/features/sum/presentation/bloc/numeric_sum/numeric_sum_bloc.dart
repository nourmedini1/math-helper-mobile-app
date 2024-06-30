import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/sum/data/models/sum_request.dart';
import 'package:math_helper/features/sum/data/models/sum_response.dart';
import 'package:math_helper/features/sum/domain/usecases/numeric_sum_usecase.dart';
import 'package:meta/meta.dart';

part 'numeric_sum_event.dart';
part 'numeric_sum_state.dart';

class NumericSumBloc extends Bloc<NumericSumEvent, NumericSumState> {
  final NumericSumUsecase numericSumUsecase;
  NumericSumBloc({required this.numericSumUsecase})
      : super(NumericSumInitial()) {
    on<NumericSumEvent>((event, emit) async {
      emit(NumericSumLoading());
      final result = await numericSumUsecase(event.request);
      result.fold(
        (failure) => emit(NumericSumFailure(message: failure.message)),
        (response) => emit(NumericSumSuccess(response: response)),
      );
    }, transformer: droppable());
  }
}
