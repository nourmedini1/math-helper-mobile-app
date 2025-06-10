import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'numeric_product_fields_state.dart';

class NumericProductFieldsCubit extends Cubit<NumericProductFieldsState> {
  NumericProductFieldsCubit() : super(NumericProductFieldsMissing());

  void checkAllFieldsReady(bool isFilled) {
    if (isFilled) {
      emit(NumericProductFieldsReady());
    } else {
      emit(NumericProductFieldsMissing());
    }
  }
  void reset() {
    emit(NumericProductFieldsMissing());
  }
}
