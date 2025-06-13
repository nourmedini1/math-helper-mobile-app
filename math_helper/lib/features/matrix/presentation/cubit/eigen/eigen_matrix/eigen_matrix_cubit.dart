import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'eigen_matrix_state.dart';

class EigenMatrixCubit extends Cubit<EigenMatrixState> {
  EigenMatrixCubit() : super(EigenMatrixInitial());

   void checkStatus(bool isAnyFieldsFilled, int rows, int columns) {
    if (isAnyFieldsFilled) {
      emit(EigenMatrixGenerated(rows: rows, columns: columns));
    } else {
        emit(EigenMatrixInitial());
    }
  }

  void reset() {
    emit(EigenMatrixInitial());
  }
}
