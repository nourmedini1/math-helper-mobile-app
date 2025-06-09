import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'single_definite_integral_limits_text_state.dart';

class SingleDefiniteIntegralLimitsTextCubit extends Cubit<SingleDefiniteIntegralLimitsTextState> {
  SingleDefiniteIntegralLimitsTextCubit() : super(SingleDefiniteIntegralLimitsTextInitial());

  void updateLowerLimitText(String lowerLimitText) {
    final currentState = state as SingleDefiniteIntegralLimitsTextInitial;
    emit(currentState.copyWith(
      lowerLimitText: lowerLimitText,
      text: "Limits : {$lowerLimitText, ${currentState.upperLimitText}}",
    ));
  }
  void updateUpperLimitText(String upperLimitText) {
    final currentState = state as SingleDefiniteIntegralLimitsTextInitial;
    emit(currentState.copyWith(
      upperLimitText: upperLimitText,
      text: "Limits : {${currentState.lowerLimitText}, $upperLimitText}",
    ));
  }
  void resetText() {
    emit(SingleDefiniteIntegralLimitsTextInitial());
  }
}
