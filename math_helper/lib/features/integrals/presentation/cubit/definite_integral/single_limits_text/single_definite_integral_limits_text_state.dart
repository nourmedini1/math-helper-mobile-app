part of 'single_definite_integral_limits_text_cubit.dart';

@immutable
sealed class SingleDefiniteIntegralLimitsTextState {}

final class SingleDefiniteIntegralLimitsTextInitial extends SingleDefiniteIntegralLimitsTextState {
  final String lowerLimitText;
  final String upperLimitText;
  final String text;
  SingleDefiniteIntegralLimitsTextInitial({
    this.lowerLimitText = "0",
    this.upperLimitText = "10",
    this.text = 'Limits : {0, 10}',
  });

  SingleDefiniteIntegralLimitsTextInitial copyWith({
    String? lowerLimitText,
    String? upperLimitText,
    String? text,
  }) {
    return SingleDefiniteIntegralLimitsTextInitial(
      lowerLimitText: lowerLimitText ?? this.lowerLimitText,
      upperLimitText: upperLimitText ?? this.upperLimitText,
      text: text ?? this.text,
    );
  }

}
