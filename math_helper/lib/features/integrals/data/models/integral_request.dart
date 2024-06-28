import 'package:equatable/equatable.dart';

class IntegralLimits extends Equatable {
  final Object lowerLimit;
  final Object upperLimit;

  const IntegralLimits({required this.lowerLimit, required this.upperLimit});

  Map<String, dynamic> toJson() {
    return {
      'lowerLimit': lowerLimit,
      'upperLimit': upperLimit,
    };
  }

  @override
  List<Object?> get props => [lowerLimit, upperLimit];
}

class IntegralRequest extends Equatable {
  final String expression;
  final List<String> variables;
  final List<IntegralLimits>? limits;

  const IntegralRequest({
    required this.expression,
    required this.variables,
    this.limits,
  });

  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'variables': variables,
      'limits': limits?.map((x) => x.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [expression, variables, limits];
}
