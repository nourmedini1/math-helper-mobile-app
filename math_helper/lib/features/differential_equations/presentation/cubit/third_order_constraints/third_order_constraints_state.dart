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
}
