part of 'second_order_coefficients_cubit.dart';

@immutable
sealed class SecondOrderCoefficientsState {}

final class SecondOrderCoefficientsInitial extends SecondOrderCoefficientsState {

  final String firstCoefficients;
  final String secondCoefficients;
  final String thirdCoefficients;
  final String text;

  SecondOrderCoefficientsInitial({
    this.firstCoefficients = "0",
    this.secondCoefficients = "0",
    this.thirdCoefficients = "0",
    this.text = 'Coefficients : {0, 0, 0}',
   
  });
}
