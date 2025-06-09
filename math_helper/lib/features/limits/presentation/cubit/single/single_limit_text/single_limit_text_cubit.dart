import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'single_limit_text_state.dart';

class SingleLimitTextCubit extends Cubit<SingleLimitTextState> {
  SingleLimitTextCubit() : super(SingleLimitTextInitial());

  void updateXValue(String xValue) {
    final currentState = state;
    if (currentState is SingleLimitTextInitial) {
      emit(currentState.copyWith(xValue: xValue));
    }
  }
  void updateSign(String sign) {
    final currentState = state;
    if (currentState is SingleLimitTextInitial) {
      emit(currentState.copyWith(sign: sign));
    }
  }
  void reset() {
    emit(SingleLimitTextInitial());
  }
}
