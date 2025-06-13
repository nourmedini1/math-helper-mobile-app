import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'multiplication_second_matrix_state.dart';

class MultiplicationSecondMatrixCubit extends Cubit<MultiplicationSecondMatrixState> {
  MultiplicationSecondMatrixCubit() : super(MultiplicationSecondMatrixInitial());

  void checkStatus(bool isAnyFieldsFilled, int rows, int columns) {
    if (isAnyFieldsFilled) {
      emit(MultiplicationSecondMatrixGenerated(rows: rows, columns: columns));
    } else {
      emit(MultiplicationSecondMatrixInitial());
    }
  }

  void reset() {
    emit(MultiplicationSecondMatrixInitial());
  }
}
