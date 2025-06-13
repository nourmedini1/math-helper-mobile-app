import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'multiplication_first_matrix_state.dart';

class MultiplicationFirstMatrixCubit extends Cubit<MultiplicationFirstMatrixState> {
  MultiplicationFirstMatrixCubit() : super(MultiplicationFirstMatrixInitial());

  void checkStatus(bool isAnyFieldsFilled, int rows, int columns) {
    if (isAnyFieldsFilled) {
      emit(MultiplicationFirstMatrixGenerated(rows: rows, columns: columns));
    } else {
        emit(MultiplicationFirstMatrixInitial());
    }
  }

  void reset() {
    emit(MultiplicationFirstMatrixInitial());
  }
}
