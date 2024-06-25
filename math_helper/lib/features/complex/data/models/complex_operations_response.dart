import 'package:equatable/equatable.dart';

class ComplexOperationsResponse extends Equatable {
  final String z1;
  final String z2;
  final String polarZ1;
  final String polarZ2;
  final String algebraicResult;
  final String polarResult;

  const ComplexOperationsResponse({
    required this.z1,
    required this.z2,
    required this.polarZ1,
    required this.polarZ2,
    required this.algebraicResult,
    required this.polarResult,
  });

  factory ComplexOperationsResponse.fromJson(Map<String, dynamic> json) {
    return ComplexOperationsResponse(
      z1: json['z1'],
      z2: json['z2'],
      polarZ1: json['polarZ1'],
      polarZ2: json['polarZ2'],
      algebraicResult: json['algebraicResult'],
      polarResult: json['polarResult'],
    );
  }

  @override
  List<Object> get props =>
      [z1, z2, polarZ1, polarZ2, algebraicResult, polarResult];
}
