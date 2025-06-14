import 'package:equatable/equatable.dart';

class ComplexOperationsRequest extends Equatable {
  final String real1;
  final String imaginary1;
  final String real2;
  final String imaginary2;

  const ComplexOperationsRequest({
    required this.real1,
    required this.imaginary1,
    required this.real2,
    required this.imaginary2,
  });

  Map<String, dynamic> toJson() {
    return {
      'real1': real1,
      'imaginary1': imaginary1,
      'real2': real2,
      'imaginary2': imaginary2,
    };
  }

  @override
  List<Object> get props => [real1, imaginary1, real2, imaginary2];
}
