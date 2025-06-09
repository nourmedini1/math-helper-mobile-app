import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'triple_limit_text_state.dart';

class TripleLimitTextCubit extends Cubit<TripleLimitTextState> {
  TripleLimitTextCubit() : super(TripleLimitTextInitial());

  void updateXValue(String xValue) {
    final currentState = state;
    if (currentState is TripleLimitTextInitial) {
      emit(currentState.copyWith(xValue: xValue));
    }
  }
  void updateYValue(String yValue) {
    final currentState = state;
    if (currentState is TripleLimitTextInitial) {
      emit(currentState.copyWith(yValue: yValue));
    }
  }
  void updateZValue(String zValue) {
    final currentState = state;
    if (currentState is TripleLimitTextInitial) {
      emit(currentState.copyWith(zValue: zValue));
    }
  }

  void updateSignX(String signX) {
    final currentState = state;
    if (currentState is TripleLimitTextInitial) {
      emit(currentState.copyWith(signX: signX));
    }
  }

  void updateSignY(String signY) {
    final currentState = state;
    if (currentState is TripleLimitTextInitial) {
      emit(currentState.copyWith(signY: signY));
    }
  }
  void updateSignZ(String signZ) {
    final currentState = state;
    if (currentState is TripleLimitTextInitial) {
      emit(currentState.copyWith(signZ: signZ));
    }
  }
  void reset() {
    emit(TripleLimitTextInitial());
  }
}
