import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'invert_matrix_state.dart';

class InvertMatrixCubit extends Cubit<InvertMatrixState> {
  InvertMatrixCubit() : super(InvertMatrixInitial());

  void checkStatus(bool isAnyFieldsFilled, int rows, int columns) {
    if (isAnyFieldsFilled) {
      emit(InvertMatrixGenerated(rows: rows, columns: columns));
    } else {
      emit(InvertMatrixInitial());
    }
  }
  void reset() {
    emit(InvertMatrixInitial());
  }
  bool isFieldsReady() {
    return state is InvertMatrixGenerated;
  }
}
