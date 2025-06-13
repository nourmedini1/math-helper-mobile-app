import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rank_matrix_state.dart';

class RankMatrixCubit extends Cubit<RankMatrixState> {
  RankMatrixCubit() : super(RankMatrixInitial());

  void checkStatus(bool isAnyFieldsFilled, int rows, int columns) {
    if (isAnyFieldsFilled) {
      emit(RankMatrixGenerated(rows: rows, columns: columns));
    } else {
      emit(RankMatrixInitial());
    }
  }
  void reset() {
    emit(RankMatrixInitial());
  }
  bool isFieldsReady() {
    return state is RankMatrixGenerated;
  }
}
