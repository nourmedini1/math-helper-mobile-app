import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'double_limit_text_state.dart';

class DoubleLimitTextCubit extends Cubit<DoubleLimitTextState> {
  DoubleLimitTextCubit() : super(DoubleLimitTextInitial());
  void updateXValue(String xValue) {
    final currentState = state;
    if (currentState is DoubleLimitTextInitial) {
      emit(currentState.copyWith(xValue: xValue));
    }
  }
  void updateYValue(String yValue) {
    final currentState = state;
    if (currentState is DoubleLimitTextInitial) {
      emit(currentState.copyWith(yValue: yValue));
    }
  }
  void updateSignX(String signX) {
    final currentState = state;
    if (currentState is DoubleLimitTextInitial) {
      emit(currentState.copyWith(signX: signX));
    }
  }
  void updateSignY(String signY) {
    final currentState = state;
    if (currentState is DoubleLimitTextInitial) {
      emit(currentState.copyWith(signY: signY));
    }
  }
  void reset() {
    emit(DoubleLimitTextInitial());
  }
}
