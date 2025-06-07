import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'second_order_coefficients_state.dart';

class SecondOrderCoefficientsCubit extends Cubit<SecondOrderCoefficientsState> {
  SecondOrderCoefficientsCubit() : super(SecondOrderCoefficientsInitial());

  void updateFirstCoefficients(String firstCoefficients) {
    final currentState = state as SecondOrderCoefficientsInitial;
    emit(SecondOrderCoefficientsInitial(
      firstCoefficients: firstCoefficients,
      secondCoefficients: currentState.secondCoefficients,
      thirdCoefficients: currentState.thirdCoefficients,
      text: "Coefficients : {$firstCoefficients, ${currentState.secondCoefficients}, ${currentState.thirdCoefficients}}",
      ));
  }

  void updateSecondCoefficients(String secondCoefficients) {
    final currentState = state as SecondOrderCoefficientsInitial;
    emit(SecondOrderCoefficientsInitial(
      firstCoefficients: currentState.firstCoefficients,
      secondCoefficients: secondCoefficients,
      thirdCoefficients: currentState.thirdCoefficients,
      text: "Coefficients : {${currentState.firstCoefficients}, $secondCoefficients, ${currentState.thirdCoefficients}}",
   ));
  }

  void updateThirdCoefficients(String thirdCoefficients) {
    final currentState = state as SecondOrderCoefficientsInitial;
    emit(SecondOrderCoefficientsInitial(
      firstCoefficients: currentState.firstCoefficients,
      secondCoefficients: currentState.secondCoefficients,
      thirdCoefficients: thirdCoefficients,
      text: "Coefficients : {${currentState.firstCoefficients}, ${currentState.secondCoefficients}, $thirdCoefficients}",
    ));
  }
  void resetText() {
    emit(SecondOrderCoefficientsInitial());
  }
}
