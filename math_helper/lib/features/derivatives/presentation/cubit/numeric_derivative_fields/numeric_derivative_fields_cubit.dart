import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'numeric_derivative_fields_state.dart';

class NumericDerivativeFieldsCubit extends Cubit<NumericDerivativeFieldsState> {
  NumericDerivativeFieldsCubit() : super(NumericDerivativeFieldsMissing());

  void checkFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(NumericDerivativeFieldsReady());
    } else {
      emit(NumericDerivativeFieldsMissing());
    }
  }

  void reset() {
    emit(NumericDerivativeFieldsMissing());
  }
}
