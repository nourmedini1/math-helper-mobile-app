part of 'single_limit_text_cubit.dart';

@immutable
sealed class SingleLimitTextState {}

final class SingleLimitTextInitial extends SingleLimitTextState {
  final String xValue;
  final String sign;
  final String text;

  SingleLimitTextInitial({
    this.xValue = '0',
    this.sign = '+',
  }) : text = 'Limit : {$xValue, $sign}';

  SingleLimitTextInitial copyWith({String? xValue, String? sign}) {
    return SingleLimitTextInitial(
      xValue: xValue ?? this.xValue,
      sign: sign ?? this.sign,
    );
  }
}
