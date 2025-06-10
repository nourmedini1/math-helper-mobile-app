import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'numeric_sum_fields_state.dart';

class NumericSumFieldsCubit extends Cubit<NumericSumFieldsState> {
  NumericSumFieldsCubit() : super(NumericSumFieldsMissing());

  void checkAllFieldsReady(bool isFilled) {
    if (isFilled) {
      emit(NumericSumFieldsReady());
    } else {
      emit(NumericSumFieldsMissing());
    }
  }
  void reset() {
    emit(NumericSumFieldsMissing());
  }
}
