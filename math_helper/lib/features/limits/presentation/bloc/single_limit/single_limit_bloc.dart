import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/limits/data/models/limit_request.dart';
import 'package:math_helper/features/limits/data/models/limit_response.dart';
import 'package:math_helper/features/limits/domain/usecases/single_limit_usecase.dart';
import 'package:meta/meta.dart';

part 'single_limit_event.dart';
part 'single_limit_state.dart';

class SingleLimitBloc extends Bloc<SingleLimitEvent, SingleLimitState> {
  final SingleLimitUsecase singleLimitUsecase;
  SingleLimitBloc({required this.singleLimitUsecase})
      : super(SingleLimitInitial()) {
    on<SingleLimitEvent>((event, emit) async {
      emit(SingleLimitLoading());
      final result = await singleLimitUsecase(event.request);
      result.fold(
        (failure) => emit(SingleLimitFailure(message: failure.message)),
        (response) => emit(SingleLimitSuccess(response: response)),
      );
    }, transformer: droppable());
  }
}
