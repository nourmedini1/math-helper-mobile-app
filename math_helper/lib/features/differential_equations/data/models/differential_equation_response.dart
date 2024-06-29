import 'package:equatable/equatable.dart';

class DifferentialEquationResponse extends Equatable {
  final String equation;
  final String solution;

  const DifferentialEquationResponse(
      {required this.equation, required this.solution});

  factory DifferentialEquationResponse.fromJson(Map<String, dynamic> json) {
    return DifferentialEquationResponse(
      equation: json['equation'],
      solution: json['solution'],
    );
  }

  @override
  List<Object> get props => [equation, solution];
}
