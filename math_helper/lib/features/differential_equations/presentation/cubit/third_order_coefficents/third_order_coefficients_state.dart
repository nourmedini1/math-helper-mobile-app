part of 'third_order_coefficients_cubit.dart';

@immutable
sealed class ThirdOrderCoefficientsState {}

final class ThirdOrderCoefficientsInitial extends ThirdOrderCoefficientsState {

  final String firstCoefficients;
  final String secondCoefficients;
  final String thirdCoefficients;
  final String fourthCoefficients;
  final String text;

  ThirdOrderCoefficientsInitial({
    this.firstCoefficients = "0",
    this.secondCoefficients = "0",
    this.thirdCoefficients = "0",
    this.fourthCoefficients = "0",
    this.text = 'Coefficients : {0, 0, 0, 0}',
  });
}
