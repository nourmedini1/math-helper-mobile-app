part of 'triple_limit_text_cubit.dart';

@immutable
sealed class TripleLimitTextState {}

final class TripleLimitTextInitial extends TripleLimitTextState {
  final String xValue;
  final String yValue;
  final String zValue;
  final String signX;
  final String signY;
  final String signZ;
  final String text;
  TripleLimitTextInitial({
    this.xValue = '0',
    this.yValue = '0',
    this.zValue = '0',
    this.signX = '+',
    this.signY = '+',
    this.signZ = '+',
  }) : text = 'Limit : {($xValue, $signX), ($yValue, $signY), ($zValue, $signZ)}';
  TripleLimitTextInitial copyWith({
    String? xValue,
    String? yValue,
    String? zValue,
    String? signX,
    String? signY,
    String? signZ,
  }) {
    return TripleLimitTextInitial(
      xValue: xValue ?? this.xValue,
      yValue: yValue ?? this.yValue,
      zValue: zValue ?? this.zValue,
      signX: signX ?? this.signX,
      signY: signY ?? this.signY,
      signZ: signZ ?? this.signZ,
    );
  }
}
