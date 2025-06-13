import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'invert_matrix_fields_state.dart';

class InvertMatrixFieldsCubit extends Cubit<InvertMatrixFieldsState> {
  InvertMatrixFieldsCubit() : super(InvertMatrixFieldsMissing());

  void checkAllFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(InvertMatrixFieldsReady());
    } else {
      emit(InvertMatrixFieldsMissing());
    }
  }
  bool isFieldsReady() {
    return state is InvertMatrixFieldsReady;
  }
  void reset() {
    emit(InvertMatrixFieldsMissing());
  }
}
