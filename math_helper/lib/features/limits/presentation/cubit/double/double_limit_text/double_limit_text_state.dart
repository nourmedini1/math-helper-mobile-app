part of 'double_limit_text_cubit.dart';

@immutable
sealed class DoubleLimitTextState {}

final class DoubleLimitTextInitial extends DoubleLimitTextState {

  final String xValue;
  final String yValue;
  final String signX;
  final String signY;
  final String text;

  DoubleLimitTextInitial({
    this.xValue = '0',
    this.yValue = '0',
    this.signX = '+',
    this.signY = '+',
  }) : text = 'Limit : {($xValue, $signX), ($yValue, $signY)}';

  DoubleLimitTextInitial copyWith({
    String? xValue,
    String? yValue,
    String? signX,
    String? signY,
  }) {
    return DoubleLimitTextInitial(
      xValue: xValue ?? this.xValue,
      yValue: yValue ?? this.yValue,
      signX: signX ?? this.signX,
      signY: signY ?? this.signY,
    );
  }
}
