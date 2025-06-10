import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'numeric_product_text_state.dart';

class NumericProductTextCubit extends Cubit<NumericProductTextState> {
  NumericProductTextCubit() : super(NumericProductTextInitial());

  void updateLowerLimit(String lowerLimit) {
    final currentState = state as NumericProductTextInitial;
    emit(currentState.copyWith(lowerLimit: lowerLimit));
  }

  void updateUpperLimit(String upperLimit) {
    final currentState = state as NumericProductTextInitial;
    emit(currentState.copyWith(upperLimit: upperLimit));
  }

  void reset() {
    emit(NumericProductTextInitial());
  }
}
