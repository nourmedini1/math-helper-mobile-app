import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'linear_system_equations_fields_state.dart';

class LinearSystemEquationsFieldsCubit extends Cubit<LinearSystemEquationsFieldsState> {
  LinearSystemEquationsFieldsCubit() : super(LinearSystemEquationsFieldsMissing());

  void checkAllFieldsFilled(bool allFilled) {
    if (allFilled) {
      emit(LinearSystemEquationsFieldsReady());
    } else {
      emit(LinearSystemEquationsFieldsMissing());
    }
  }
  void reset() {
    emit(LinearSystemEquationsFieldsMissing());
  }
}
