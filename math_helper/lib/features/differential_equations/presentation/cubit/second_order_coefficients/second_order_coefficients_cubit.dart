import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'second_order_coefficients_state.dart';

class SecondOrderCoefficientsCubit extends Cubit<SecondOrderCoefficientsState> {
  SecondOrderCoefficientsCubit() : super(SecondOrderCoefficientsInitial());

  void updateFirstCoefficients(String firstCoefficients) {
    final currentState = state as SecondOrderCoefficientsInitial;
    emit(currentState.copyWith(
      firstCoefficients: firstCoefficients,
      text: "Coefficients : {$firstCoefficients, ${currentState.secondCoefficients}, ${currentState.thirdCoefficients}}",
      ));
  }

  void updateSecondCoefficients(String secondCoefficients) {
    final currentState = state as SecondOrderCoefficientsInitial;
    emit(currentState.copyWith(   
      secondCoefficients: secondCoefficients,
      text: "Coefficients : {${currentState.firstCoefficients}, $secondCoefficients, ${currentState.thirdCoefficients}}",
   ));
  }

  void updateThirdCoefficients(String thirdCoefficients) {
    final currentState = state as SecondOrderCoefficientsInitial;
    emit(currentState.copyWith(
      thirdCoefficients: thirdCoefficients,
      text: "Coefficients : {${currentState.firstCoefficients}, ${currentState.secondCoefficients}, $thirdCoefficients}",
    ));
  }
  void resetText() {
    emit(SecondOrderCoefficientsInitial());
  }
}
