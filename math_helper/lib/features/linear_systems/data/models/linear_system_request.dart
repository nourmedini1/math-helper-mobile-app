import 'package:equatable/equatable.dart';

class LinearSystemRequest extends Equatable {
  final List<String> equations;
  final List<String> variables;
  final List<Object> rightHandSide;

  const LinearSystemRequest({
    required this.equations,
    required this.variables,
    required this.rightHandSide,
  });

  Map<String, dynamic> toJson() {
    return {
      'equations': equations,
      'variables': variables,
      'righHandSide': rightHandSide,
    };
  }

  @override
  List<Object?> get props => [equations, variables, rightHandSide];
}
