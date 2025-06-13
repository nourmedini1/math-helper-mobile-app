import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'addition_second_matrix_state.dart';

class AdditionSecondMatrixCubit extends Cubit<AdditionSecondMatrixState> {
  AdditionSecondMatrixCubit() : super(AdditionSecondMatrixInitial());

  void checkStatus(bool isAnyFieldsFilled, int rows, int columns) {
    if (isAnyFieldsFilled) {
      emit(AdditionSecondMatrixGenerated(rows: rows, columns: columns));
    } else {
        emit(AdditionSecondMatrixInitial());
    }
  }

  void reset() {
    emit(AdditionSecondMatrixInitial());
  }


}
