import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'symbolic_derivative_fields_state.dart';

class SymbolicDerivativeFieldsCubit extends Cubit<SymbolicDerivativeFieldsState> {
  SymbolicDerivativeFieldsCubit() : super(SymbolicDerivativeFieldsMissing());

  void checkFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(SymbolicDerivativeFieldsReady());
    } else {
      emit(SymbolicDerivativeFieldsMissing());
    }
  }

  void reset() {
    emit(SymbolicDerivativeFieldsMissing());
  }
}
