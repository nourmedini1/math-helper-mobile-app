import 'package:equatable/equatable.dart';

class MatrixResponse extends Equatable {
  final String? matrixA;
  final String? matrixB;
  final String? matrix;
  final String? eigenValue;
  final String? eigenVector;
  final String? determinant;
  final String? rank;

  const MatrixResponse(
      {required this.matrix,
      required this.matrixA,
      required this.matrixB,
      required this.eigenValue,
      required this.eigenVector,
      required this.determinant,
      required this.rank});

  factory MatrixResponse.fromJson(Map<String, dynamic> json) {
    return MatrixResponse(
      matrix: json['matrix'],
      eigenValue: json['eigenValue'],
      eigenVector: json['eigenVector'],
      determinant: json['determinant'],
      rank: json['rank'],
      matrixA: json['matrixA'],
      matrixB: json['matrixB'],
    );
  }

  @override
  List<Object?> get props =>
      [matrix, eigenValue, eigenVector, determinant, rank, matrixA, matrixB];
}
