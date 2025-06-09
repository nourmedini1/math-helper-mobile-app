part of 'first_order_constraints_text_cubit.dart';

@immutable
sealed class FirstOrderConstraintsTextState {}

final class FirstOrderConstraintsTextInitial extends FirstOrderConstraintsTextState {
  final List<String> firstContraints;
  final List<String> secondContraints;
  final String text;
  FirstOrderConstraintsTextInitial({
    this.firstContraints = const ['0','0'],
    this.secondContraints = const ['0','0'],
    this.text = 'Initial Conditions : {(0,0), (0,0)}',
  });

  FirstOrderConstraintsTextInitial copyWith({
    List<String>? firstContraints,
    List<String>? secondContraints,
    String? text,
  }) {
    return FirstOrderConstraintsTextInitial(
      firstContraints: firstContraints ?? this.firstContraints,
      secondContraints: secondContraints ?? this.secondContraints,
      text: text ?? this.text,
    );
  }
}
