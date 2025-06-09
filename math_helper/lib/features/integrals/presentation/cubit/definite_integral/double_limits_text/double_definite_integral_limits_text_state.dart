part of 'double_definite_integral_limits_text_cubit.dart';

@immutable
sealed class DoubleDefiniteIntegralLimitsTextState {}

final class DoubleDefiniteIntegralLimitsTextInitial extends DoubleDefiniteIntegralLimitsTextState {
  final String lowerLimitXText;
  final String upperLimitXText;
  final String lowerLimitYText;
  final String upperLimitYText;
  final String text;

  DoubleDefiniteIntegralLimitsTextInitial({
    this.lowerLimitXText = "0",
    this.upperLimitXText = "10",
    this.lowerLimitYText = "0",
    this.upperLimitYText = "10",
    this.text = 'Limits : {(0, 10), (0, 10)}',
  });

  DoubleDefiniteIntegralLimitsTextInitial copyWith({
    String? lowerLimitXText,
    String? upperLimitXText,
    String? lowerLimitYText,
    String? upperLimitYText,
    String? text,
  }) {
    return DoubleDefiniteIntegralLimitsTextInitial(
      lowerLimitXText: lowerLimitXText ?? this.lowerLimitXText,
      upperLimitXText: upperLimitXText ?? this.upperLimitXText,
      lowerLimitYText: lowerLimitYText ?? this.lowerLimitYText,
      upperLimitYText: upperLimitYText ?? this.upperLimitYText,
      text: text ?? this.text,
    );
  }
}
