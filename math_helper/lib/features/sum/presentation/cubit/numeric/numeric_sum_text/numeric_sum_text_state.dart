part of 'numeric_sum_text_cubit.dart';

@immutable
sealed class NumericSumTextState {}

final class NumericSumTextInitial extends NumericSumTextState {
  final String lowerLimit;
  final String upperLimit;
  final String text;

  NumericSumTextInitial({
    this.lowerLimit = "0",
    this.upperLimit = "oo",
  }) : text = "lower limit: $lowerLimit, upper limit: $upperLimit";

  NumericSumTextInitial copyWith({
    String? lowerLimit,
    String? upperLimit,
  }) {
    return NumericSumTextInitial(
      lowerLimit: lowerLimit ?? this.lowerLimit,
      upperLimit: upperLimit ?? this.upperLimit,
    );
  }
}
