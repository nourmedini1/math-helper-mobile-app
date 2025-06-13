import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'addition_first_matrix_state.dart';

class AdditionFirstMatrixCubit extends Cubit<AdditionFirstMatrixState> {
  AdditionFirstMatrixCubit() : super(AdditionFirstMatrixInitial());
  
void checkStatus(bool isAnyFieldsFilled, int rows, int columns) {
    if (isAnyFieldsFilled) {
      emit(AdditionFirstMatrixGenerated(rows: rows, columns: columns));
    } else {
        emit(AdditionFirstMatrixInitial());
    }
  }

  void reset() {
    emit(AdditionFirstMatrixInitial());
  }
}
