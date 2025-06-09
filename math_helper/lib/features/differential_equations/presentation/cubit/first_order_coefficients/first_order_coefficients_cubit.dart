import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'first_order_coefficients_state.dart';

class FirstOrderCoefficientsCubit extends Cubit<FirstOrderCoefficientsState> {
  FirstOrderCoefficientsCubit() : super(FirstOrderCoefficientsInitial());

  void updateFirstCoefficients(String firstCoefficients) {
    final currentState = state as FirstOrderCoefficientsInitial;
    emit(currentState.copyWith(
      firstCoefficients: firstCoefficients,
      text: "Coefficients : {$firstCoefficients, ${currentState.secondCoefficients}}",
    ));
  }
  void updateSecondCoefficients(String secondCoefficients) {
    final currentState = state as FirstOrderCoefficientsInitial;
    emit(currentState.copyWith(
      secondCoefficients: secondCoefficients,
      text: "Coefficients : {${currentState.firstCoefficients}, $secondCoefficients}",
    ));
  }
  void resetText() {
    emit(FirstOrderCoefficientsInitial());
  }
}
