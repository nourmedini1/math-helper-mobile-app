import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'determinant_matrix_state.dart';

class DeterminantMatrixCubit extends Cubit<DeterminantMatrixState> {
  DeterminantMatrixCubit() : super(DeterminantMatrixInitial());

  void checkStatus(bool isAnyFieldsFilled, int rows, int columns) {
    if (isAnyFieldsFilled) {
      emit(DeterminantMatrixGenerated(rows: rows, columns: columns));
    } else {
        emit(DeterminantMatrixInitial());
    }
  }

  void reset() {
    emit(DeterminantMatrixInitial());
  }
}


