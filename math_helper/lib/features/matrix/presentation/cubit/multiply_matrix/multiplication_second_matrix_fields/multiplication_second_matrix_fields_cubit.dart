import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'multiplication_second_matrix_fields_state.dart';

class MultiplicationSecondMatrixFieldsCubit extends Cubit<MultiplicationSecondMatrixFieldsState> {
  MultiplicationSecondMatrixFieldsCubit() : super(MultiplicationSecondMatrixFieldsMissing());

  void checkAllFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(MultiplicationSecondMatrixFieldsReady());
    } else {
      emit(MultiplicationSecondMatrixFieldsMissing());
    }
  }

  bool isFieldsReady() {
    return state is MultiplicationSecondMatrixFieldsReady;
  }
  void reset() {
    emit(MultiplicationSecondMatrixFieldsMissing());
  }
}
