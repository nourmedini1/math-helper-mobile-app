import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'numeric_sum_text_state.dart';

class NumericSumTextCubit extends Cubit<NumericSumTextState> {
  NumericSumTextCubit() : super(NumericSumTextInitial());

  void updateLowerLimit(String lowerLimit) {
    final currentState = state as NumericSumTextInitial;
    emit(currentState.copyWith(lowerLimit: lowerLimit));
  }

  void updateUpperLimit(String upperLimit) {
    final currentState = state as NumericSumTextInitial;
    emit(currentState.copyWith(upperLimit: upperLimit));
  }

  void reset() {
    emit(NumericSumTextInitial());
  }
}
