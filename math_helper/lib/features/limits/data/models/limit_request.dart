import 'package:equatable/equatable.dart';

class Bound extends Equatable {
  final Object value;
  final String? sign;

  const Bound({required this.value, this.sign});

  Map<String, dynamic> toJson() {
    return {'value': value, 'sign': sign};
  }

  @override
  List<Object?> get props => [value, sign];
}

class LimitRequest extends Equatable {
  final String expression;
  final List<String> variables;
  final List<Bound> bounds;

  const LimitRequest({
    required this.expression,
    required this.variables,
    required this.bounds,
  });

  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'variables': variables,
      'bounds': bounds.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [expression, variables, bounds];
}
