import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/labels.dart';
import 'package:math_helper/core/storage/local_storage_service.dart';
import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/features/matrix/data/models/matrix_request.dart';
import 'package:math_helper/features/matrix/data/models/matrix_response.dart';
import 'package:math_helper/features/matrix/domain/usecases/get_rank_usecase.dart';
import 'package:meta/meta.dart';

part 'rank_event.dart';
part 'rank_state.dart';

class RankBloc extends Bloc<RankEvent, RankState> {
  final GetRankUsecase getRankUsecase;
  RankBloc({required this.getRankUsecase}) : super(RankInitial()) {
    on<RankEvent>((event, emit) async {
      if (event is RankReset) {
        emit(RankInitial());
      }
      if (event is RankRequested) {
        emit(RankLoading());
        final result = await getRankUsecase(event.request);
        result.fold((failure) => emit(RankFailure(message: failure.message)),
            (response) {
          ic<LocalStorageService>().registerOperation(Operation(
              title: "Matrix Rank",
              results: [response.matrixA!, response.rank!],
              doneAt: DateTime.now(),
              label: Labels.RANK_MATRIX_LABEL));
          emit(RankSuccess(response: response));
        });
      }
    }, transformer: droppable());
  }
}
