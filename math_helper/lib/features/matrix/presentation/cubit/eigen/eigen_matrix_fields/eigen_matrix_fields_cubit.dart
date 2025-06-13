import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'eigen_matrix_fields_state.dart';

class EigenMatrixFieldsCubit extends Cubit<EigenMatrixFieldsState> {
  EigenMatrixFieldsCubit() : super(EigenMatrixFieldsMissing());

  void checkAllFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(EigenMatrixFieldsReady());
    } else {
      emit(EigenMatrixFieldsMissing());
    }
  }
  bool isFieldsReady() {
    return state is EigenMatrixFieldsReady;
  }
  void reset() {
    emit(EigenMatrixFieldsMissing());
  }
}
