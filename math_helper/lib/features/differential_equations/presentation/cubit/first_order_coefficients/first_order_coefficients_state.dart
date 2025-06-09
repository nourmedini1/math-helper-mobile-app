part of 'first_order_coefficients_cubit.dart';

@immutable
sealed class FirstOrderCoefficientsState {}

final class FirstOrderCoefficientsInitial extends FirstOrderCoefficientsState {

  final String firstCoefficients;
  final String secondCoefficients;
  final String text;
  FirstOrderCoefficientsInitial({
    this.firstCoefficients = "0",
    this.secondCoefficients = "0",
    this.text = 'Coefficients : {0, 0}',
  });

  FirstOrderCoefficientsInitial copyWith({
    String? firstCoefficients,
    String? secondCoefficients,
    String? text,
  }) {
    return FirstOrderCoefficientsInitial(
      firstCoefficients: firstCoefficients ?? this.firstCoefficients,
      secondCoefficients: secondCoefficients ?? this.secondCoefficients,
      text: text ?? this.text,
    );
  }
}
