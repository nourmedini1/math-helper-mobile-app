import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/sum/data/models/sum_request.dart';
import 'package:math_helper/features/sum/data/models/sum_response.dart';
import 'package:math_helper/features/sum/domain/usecases/symbolic_sum_usecase.dart';
import 'package:meta/meta.dart';

part 'symbolic_sum_event.dart';
part 'symbolic_sum_state.dart';

class SymbolicSumBloc extends Bloc<SymbolicSumEvent, SymbolicSumState> {
  final SymbolicSumUsecase symbolicSumUsecase;
  SymbolicSumBloc({required this.symbolicSumUsecase})
      : super(SymbolicSumInitial()) {
    on<SymbolicSumEvent>((event, emit) async {
      emit(SymbolicSumLoading());
      final result = await symbolicSumUsecase(event.request);
      result.fold(
        (failure) => emit(SymbolicSumFailure(message: failure.message)),
        (response) => emit(SymbolicSumSuccess(response: response)),
      );
    }, transformer: droppable());
  }
}
