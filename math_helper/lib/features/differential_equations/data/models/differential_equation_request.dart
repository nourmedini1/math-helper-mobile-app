import 'package:equatable/equatable.dart';

class InitialCondition extends Equatable {
  final String x;
  final String y;

  const InitialCondition({required this.x, required this.y});

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }

  @override
  List<Object> get props => [x, y];
}

class DifferentialEquationRequest extends Equatable {
  final String variable;
  final List<String?> coefficients;
  final List<InitialCondition?> initialConditions;
  final String? constant;
  final String? rightHandSide;

  const DifferentialEquationRequest(
      {required this.variable,
      required this.coefficients,
      required this.initialConditions,
      this.constant,
      this.rightHandSide});

  Map<String, dynamic> toJson() {
    return {
      'variable': variable,
      'coefficients': coefficients,
      'initialConditions': initialConditions.map((x) => x?.toJson()).toList(),
      'constant': constant,
      'rightHandSide': rightHandSide,
    };
  }

  @override
  List<Object> get props =>
      [variable, initialConditions, coefficients, constant!, rightHandSide!];
}
