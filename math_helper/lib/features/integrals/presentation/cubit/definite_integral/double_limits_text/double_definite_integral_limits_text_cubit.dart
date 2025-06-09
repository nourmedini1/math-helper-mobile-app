import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'double_definite_integral_limits_text_state.dart';

class DoubleDefiniteIntegralLimitsTextCubit extends Cubit<DoubleDefiniteIntegralLimitsTextState> {
  DoubleDefiniteIntegralLimitsTextCubit() : super(DoubleDefiniteIntegralLimitsTextInitial());

  void updateLowerLimitXText(String lowerLimitXText) {
    final currentState = state as DoubleDefiniteIntegralLimitsTextInitial;
    emit(currentState.copyWith(
      lowerLimitXText: lowerLimitXText,
      text: "Limits : {($lowerLimitXText, ${currentState.upperLimitXText}), (${currentState.lowerLimitYText}, ${currentState.upperLimitYText})}",
    ));
  }

  void updateUpperLimitXText(String upperLimitXText) {
    final currentState = state as DoubleDefiniteIntegralLimitsTextInitial;
    emit(currentState.copyWith(
      upperLimitXText: upperLimitXText,
      text: "Limits : {(${currentState.lowerLimitXText}, $upperLimitXText), (${currentState.lowerLimitYText}, ${currentState.upperLimitYText})}",
    ));
  }

  void updateLowerLimitYText(String lowerLimitYText) {
    final currentState = state as DoubleDefiniteIntegralLimitsTextInitial;
    emit(currentState.copyWith(
      lowerLimitYText: lowerLimitYText,
      text: "Limits : {(${currentState.lowerLimitXText}, ${currentState.upperLimitXText}), ($lowerLimitYText, ${currentState.upperLimitYText})}",
    ));
  }
  void updateUpperLimitYText(String upperLimitYText) {
    final currentState = state as DoubleDefiniteIntegralLimitsTextInitial;
    emit(currentState.copyWith(
      upperLimitYText: upperLimitYText,
      text: "Limits : {(${currentState.lowerLimitXText}, ${currentState.upperLimitXText}), (${currentState.lowerLimitYText}, $upperLimitYText)}",
    ));
  }
  void resetText() {
    emit(DoubleDefiniteIntegralLimitsTextInitial());
  }
}
