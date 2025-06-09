part of 'third_order_constraints_cubit.dart';

@immutable
sealed class ThirdOrderConstraintsState {}

final class ThirdOrderConstraintsInitial extends ThirdOrderConstraintsState {

  final List<String> firstConstraints;
  final List<String> secondConstraints;
  final List<String> thirdConstraints;
  final List<String> fourthConstraints;
  final String text;

  ThirdOrderConstraintsInitial({
    this.firstConstraints = const ['0', '0'],
    this.secondConstraints = const ['0', '0'],
    this.thirdConstraints = const ['0', '0'],
    this.fourthConstraints = const ['0', '0'],
    this.text = 'Initial Conditions : {(0,0), (0,0), (0,0), (0,0)}',
  });

  ThirdOrderConstraintsInitial copyWith({
    List<String>? firstConstraints,
    List<String>? secondConstraints,
    List<String>? thirdConstraints,
    List<String>? fourthConstraints,
    String? text,
  }) {
    return ThirdOrderConstraintsInitial(
      firstConstraints: firstConstraints ?? this.firstConstraints,
      secondConstraints: secondConstraints ?? this.secondConstraints,
      thirdConstraints: thirdConstraints ?? this.thirdConstraints,
      fourthConstraints: fourthConstraints ?? this.fourthConstraints,
      text: text ?? this.text,
    );
  }
}
