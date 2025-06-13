import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'determinant_matrix_fields_state.dart';

class DeterminantMatrixFieldsCubit extends Cubit<DeterminantMatrixFieldsState> {
  DeterminantMatrixFieldsCubit() : super(DeterminantMatrixFieldsMissing());

  void checkAllFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(DeterminantMatrixFieldsReady());
    } else {
      emit(DeterminantMatrixFieldsMissing());
    }
  }
  bool isFieldsReady() {
    return state is DeterminantMatrixFieldsReady;
  }
  void reset() {
    emit(DeterminantMatrixFieldsMissing());
  }
}
