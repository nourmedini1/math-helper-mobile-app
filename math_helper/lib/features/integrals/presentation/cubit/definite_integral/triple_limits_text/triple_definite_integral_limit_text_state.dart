part of 'triple_definite_integral_limit_text_cubit.dart';

@immutable
sealed class TripleDefiniteIntegralLimitTextState {}

final class TripleDefiniteIntegralLimitTextInitial extends TripleDefiniteIntegralLimitTextState {

  final String lowerLimitXText;
  final String upperLimitXText;
  final String lowerLimitYText;
  final String upperLimitYText;
  final String lowerLimitZText;
  final String upperLimitZText;
  final String text;

  TripleDefiniteIntegralLimitTextInitial({
    this.lowerLimitXText = "0",
    this.upperLimitXText = "10",
    this.lowerLimitYText = "0",
    this.upperLimitYText = "10",
    this.lowerLimitZText = "0",
    this.upperLimitZText = "10",
    this.text = 'Limits : {(0, 10), (0, 10), (0, 10)}',
  });
  TripleDefiniteIntegralLimitTextInitial copyWith({
    String? lowerLimitXText,
    String? upperLimitXText,
    String? lowerLimitYText,
    String? upperLimitYText,
    String? lowerLimitZText,
    String? upperLimitZText,
    String? text,
  }) {
    return TripleDefiniteIntegralLimitTextInitial(
      lowerLimitXText: lowerLimitXText ?? this.lowerLimitXText,
      upperLimitXText: upperLimitXText ?? this.upperLimitXText,
      lowerLimitYText: lowerLimitYText ?? this.lowerLimitYText,
      upperLimitYText: upperLimitYText ?? this.upperLimitYText,
      lowerLimitZText: lowerLimitZText ?? this.lowerLimitZText,
      upperLimitZText: upperLimitZText ?? this.upperLimitZText,
      text: text ?? this.text,
    );
  }
}
