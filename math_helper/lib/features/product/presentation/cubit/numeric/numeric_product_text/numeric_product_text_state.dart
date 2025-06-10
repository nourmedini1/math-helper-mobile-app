part of 'numeric_product_text_cubit.dart';

@immutable
sealed class NumericProductTextState {}

final class NumericProductTextInitial extends NumericProductTextState {
  final String lowerLimit;
  final String upperLimit;
  final String text;

  NumericProductTextInitial({
    this.lowerLimit = "0",
    this.upperLimit = "oo",
  }) : text = "lower limit: $lowerLimit, upper limit: $upperLimit";

  NumericProductTextInitial copyWith({
    String? lowerLimit,
    String? upperLimit,
  }) {
    return NumericProductTextInitial(
      lowerLimit: lowerLimit ?? this.lowerLimit,
      upperLimit: upperLimit ?? this.upperLimit,
    );
  }
}
