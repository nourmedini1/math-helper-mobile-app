import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'addition_second_matrix_fields_state.dart';

class AdditionSecondMatrixFieldsCubit extends Cubit<AdditionSecondMatrixFieldsState> {
  AdditionSecondMatrixFieldsCubit() : super(AdditionSecondMatrixFieldsMissing());

  void checkAllFieldsReady(bool isAllFilled) {
    if (isAllFilled) {
      emit(AdditionSecondMatrixFieldsReady());
    } else {
        emit(AdditionSecondMatrixFieldsMissing());
    }
  }

  bool isFieldsReady() {
    return state is AdditionSecondMatrixFieldsReady;
  }

  void reset() {
    emit(AdditionSecondMatrixFieldsMissing());
  }
}
