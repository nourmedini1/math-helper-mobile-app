import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/limits/data/models/limit_request.dart';
import 'package:math_helper/features/limits/data/models/limit_response.dart';
import 'package:math_helper/features/limits/domain/usecases/double_limit_usecase.dart';
import 'package:meta/meta.dart';

part 'double_limit_event.dart';
part 'double_limit_state.dart';

class DoubleLimitBloc extends Bloc<DoubleLimitEvent, DoubleLimitState> {
  final DoubleLimitUsecase doubleLimitUsecase;
  DoubleLimitBloc({required this.doubleLimitUsecase})
      : super(DoubleLimitInitial()) {
    on<DoubleLimitEvent>((event, emit) async {
      if (event is DoubleLimitReset) {
        emit(DoubleLimitInitial());
      }
      if (event is DoubleLimitRequested) {
        emit(DoubleLimitLoading());
        final result = await doubleLimitUsecase(event.request);
        result.fold(
            (failure) => emit(DoubleLimitFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Double Limit",
              results: [response.limit, response.result],
              doneAt: DateTime.now(),
              label: Labels.LIMIT_LABEL));
          emit(DoubleLimitSuccess(response: response));
        });
      }
    }, transformer: droppable());
  }
}
