import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'addition_first_matrix_fields_state.dart';

class AdditionFirstMatrixFieldsCubit extends Cubit<AdditionFirstMatrixFieldsState> {
  AdditionFirstMatrixFieldsCubit() : super(AdditionFirstMatrixFieldsMissing());

  void checkAllFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(AdditionFirstMatrixFieldsReady());
    } else {
        emit(AdditionFirstMatrixFieldsMissing());
      }
  }

  bool isFieldsReady() {
    return state is AdditionFirstMatrixFieldsReady;
  }

  void reset() {
    emit(AdditionFirstMatrixFieldsMissing());
  }
}

