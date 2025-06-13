import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rank_matrix_fields_state.dart';

class RankMatrixFieldsCubit extends Cubit<RankMatrixFieldsState> {
  RankMatrixFieldsCubit() : super(RankMatrixFieldsMissing());

  void checkAllFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(RankMatrixFieldsReady());
    } else {
      emit(RankMatrixFieldsMissing());
    }
  }
  bool isFieldsReady() {
    return state is RankMatrixFieldsReady;
  }
  void reset() {
    emit(RankMatrixFieldsMissing());
  }
}
