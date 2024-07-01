import 'package:equatable/equatable.dart';

class MatrixRequest extends Equatable {
  final List<List<double>> matrixA;
  final List<List<double>>? matrixB;

  const MatrixRequest({required this.matrixA, required this.matrixB});

  Map<String, dynamic> toJson() {
    return {'matrixA': matrixA, 'matrixB': matrixB};
  }

  @override
  List<Object?> get props => [matrixA, matrixB];
}
