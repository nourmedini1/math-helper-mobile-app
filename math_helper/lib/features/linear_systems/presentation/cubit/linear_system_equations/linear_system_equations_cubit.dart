import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'linear_system_equations_state.dart';

class LinearSystemEquationsCubit extends Cubit<LinearSystemEquationsState> {
  LinearSystemEquationsCubit() : super(LinearSystemEquationsInitial());

  void checkStatus(bool isAnyFieldsFilled, int nbEquations, List<String> variables) {
    if (isAnyFieldsFilled) {
      emit(LinearSystemEquationsGenerated(
        nbEquations: nbEquations,
        variables: variables,
      ));
    } else {
      emit(LinearSystemEquationsInitial());
    }
  }
  void reset() {
    emit(LinearSystemEquationsInitial());
  }
  bool isFieldsReady() {
    return state is LinearSystemEquationsGenerated;
  }
}
