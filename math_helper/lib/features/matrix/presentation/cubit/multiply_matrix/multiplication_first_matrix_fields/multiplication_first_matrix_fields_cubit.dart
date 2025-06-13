import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'multiplication_first_matrix_fields_state.dart';

class MultiplicationFirstMatrixFieldsCubit extends Cubit<MultiplicationFirstMatrixFieldsState> {
  MultiplicationFirstMatrixFieldsCubit() : super(MultiplicationFirstMatrixFieldsMissing());

   void checkAllFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(MultiplicationFirstMatrixFieldsReady());
    } else {
        emit(MultiplicationFirstMatrixFieldsMissing());
      }
  }

  bool isFieldsReady() {
    return state is MultiplicationFirstMatrixFieldsReady;
  }

  void reset() {
    emit(MultiplicationFirstMatrixFieldsMissing());
  }
}
