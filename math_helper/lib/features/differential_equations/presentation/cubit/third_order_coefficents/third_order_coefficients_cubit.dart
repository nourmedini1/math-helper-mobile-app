import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'third_order_coefficients_state.dart';

class ThirdOrderCoefficientsCubit extends Cubit<ThirdOrderCoefficientsState> {
  ThirdOrderCoefficientsCubit() : super(ThirdOrderCoefficientsInitial());

  void updateFirstCoefficients(String firstCoefficients) {
    final currentState = state as ThirdOrderCoefficientsInitial;
    emit(currentState.copyWith(
      firstCoefficients: firstCoefficients,
      text: "Coefficients : {$firstCoefficients, ${currentState.secondCoefficients}, ${currentState.thirdCoefficients}, ${currentState.fourthCoefficients}}",
    ));
  }

  void updateSecondCoefficients(String secondCoefficients) {
    final currentState = state as ThirdOrderCoefficientsInitial;
    emit(currentState.copyWith(
      secondCoefficients: secondCoefficients,
      text: "Coefficients : {${currentState.firstCoefficients}, $secondCoefficients, ${currentState.thirdCoefficients}, ${currentState.fourthCoefficients}}",
     ));
  }

  void updateThirdCoefficients(String thirdCoefficients) {
    final currentState = state as ThirdOrderCoefficientsInitial;
    emit(currentState.copyWith(
      thirdCoefficients: thirdCoefficients,
      text: "Coefficients : {${currentState.firstCoefficients}, ${currentState.secondCoefficients}, $thirdCoefficients, ${currentState.fourthCoefficients}}",));
  }
  
  void updateFourthCoefficients(String fourthCoefficients) {
    final currentState = state as ThirdOrderCoefficientsInitial;
    emit(ThirdOrderCoefficientsInitial(
      fourthCoefficients: fourthCoefficients,
      text: "Coefficients : {${currentState.firstCoefficients}, ${currentState.secondCoefficients}, ${currentState.thirdCoefficients}, $fourthCoefficients}",));
  }
  void resetText() {
    emit(ThirdOrderCoefficientsInitial());
  }
}
