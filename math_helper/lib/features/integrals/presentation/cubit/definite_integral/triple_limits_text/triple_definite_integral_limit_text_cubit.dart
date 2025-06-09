import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'triple_definite_integral_limit_text_state.dart';

class TripleDefiniteIntegralLimitTextCubit extends Cubit<TripleDefiniteIntegralLimitTextState> {
  TripleDefiniteIntegralLimitTextCubit() : super(TripleDefiniteIntegralLimitTextInitial());

  void updateLowerLimitXText(String lowerLimitXText) {
    final currentState = state as TripleDefiniteIntegralLimitTextInitial;
    emit(currentState.copyWith(
      lowerLimitXText: lowerLimitXText,
      text: "Limits : {($lowerLimitXText, ${currentState.upperLimitXText}), (${currentState.lowerLimitYText}, ${currentState.upperLimitYText}), (${currentState.lowerLimitZText}, ${currentState.upperLimitZText})}",
    ));
  }

  void updateUpperLimitXText(String upperLimitXText) {
    final currentState = state as TripleDefiniteIntegralLimitTextInitial;
    emit(currentState.copyWith(
      upperLimitXText: upperLimitXText,
      text: "Limits : {(${currentState.lowerLimitXText}, $upperLimitXText), (${currentState.lowerLimitYText}, ${currentState.upperLimitYText}), (${currentState.lowerLimitZText}, ${currentState.upperLimitZText})}",
    ));
  }

  void updateLowerLimitYText(String lowerLimitYText) {
    final currentState = state as TripleDefiniteIntegralLimitTextInitial;
    emit(currentState.copyWith(
      lowerLimitYText: lowerLimitYText,
      text: "Limits : {(${currentState.lowerLimitXText}, ${currentState.upperLimitXText}), ($lowerLimitYText, ${currentState.upperLimitYText}), (${currentState.lowerLimitZText}, ${currentState.upperLimitZText})}",
    ));
  }
  void updateUpperLimitYText(String upperLimitYText) {
    final currentState = state as TripleDefiniteIntegralLimitTextInitial;
    emit(currentState.copyWith(
      upperLimitYText: upperLimitYText,
      text: "Limits : {(${currentState.lowerLimitXText}, ${currentState.upperLimitXText}), (${currentState.lowerLimitYText}, $upperLimitYText), (${currentState.lowerLimitZText}, ${currentState.upperLimitZText})}",
    ));
  }
  void updateLowerLimitZText(String lowerLimitZText) {
    final currentState = state as TripleDefiniteIntegralLimitTextInitial;
    emit(currentState.copyWith(
      lowerLimitZText: lowerLimitZText,
      text: "Limits : {(${currentState.lowerLimitXText}, ${currentState.upperLimitXText}), (${currentState.lowerLimitYText}, ${currentState.upperLimitYText}), ($lowerLimitZText, ${currentState.upperLimitZText})}",
    ));
  }
  void updateUpperLimitZText(String upperLimitZText) {
    final currentState = state as TripleDefiniteIntegralLimitTextInitial;
    emit(currentState.copyWith(
      upperLimitZText: upperLimitZText,
      text: "Limits : {(${currentState.lowerLimitXText}, ${currentState.upperLimitXText}), (${currentState.lowerLimitYText}, ${currentState.upperLimitYText}), (${currentState.lowerLimitZText}, $upperLimitZText)}",
    ));
  }
  void resetText() {
    emit(TripleDefiniteIntegralLimitTextInitial());
  }
}
