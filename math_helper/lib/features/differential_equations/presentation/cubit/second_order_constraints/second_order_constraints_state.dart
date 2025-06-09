part of 'second_order_constraints_cubit.dart';

@immutable
sealed class SecondOrderConstraintsState {}

final class SecondOrderConstraintsInitial extends SecondOrderConstraintsState {

  final List<String> firstConstraints;
  final List<String> secondConstraints;
  final List<String> thirdConstraints;
  final String text;

  SecondOrderConstraintsInitial({
    this.firstConstraints = const ['0', '0'],
    this.secondConstraints = const ['0', '0'],
    this.thirdConstraints = const ['0', '0'],
    this.text = 'Initial Conditions : {(0,0), (0,0), (0,0)}',
  });

  SecondOrderConstraintsInitial copyWith({
    List<String>? firstConstraints,
    List<String>? secondConstraints,
    List<String>? thirdConstraints,
    String? text,
  }) {
    return SecondOrderConstraintsInitial(
      firstConstraints: firstConstraints ?? this.firstConstraints,
      secondConstraints: secondConstraints ?? this.secondConstraints,
      thirdConstraints: thirdConstraints ?? this.thirdConstraints,
      text: text ?? this.text,
    );
  }
}
