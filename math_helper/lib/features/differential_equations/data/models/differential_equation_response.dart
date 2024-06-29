import 'package:equatable/equatable.dart';

class DifferentialEquationResponse extends Equatable {
  final String equation;
  final String solution;

  const DifferentialEquationResponse(
      {required this.equation, required this.solution});

  @override
  List<Object> get props => [equation, solution];
}
