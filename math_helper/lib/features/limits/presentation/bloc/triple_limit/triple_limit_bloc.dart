import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/limits/data/models/limit_request.dart';
import 'package:math_helper/features/limits/data/models/limit_response.dart';
import 'package:math_helper/features/limits/domain/usecases/triple_limit_usecase.dart';
import 'package:meta/meta.dart';

part 'triple_limit_event.dart';
part 'triple_limit_state.dart';

class TripleLimitBloc extends Bloc<TripleLimitEvent, TripleLimitState> {
  final TripleLimitUsecase tripleLimitUsecase;
  TripleLimitBloc({required this.tripleLimitUsecase})
      : super(TripleLimitInitial()) {
    on<TripleLimitEvent>((event, emit) async {
      emit(TripleLimitLoading());
      final result = await tripleLimitUsecase(event.request);
      result.fold(
        (failure) => emit(TripleLimitFailure(message: failure.message)),
        (response) => emit(TripleLimitSuccess(response: response)),
      );
    }, transformer: droppable());
  }
}
