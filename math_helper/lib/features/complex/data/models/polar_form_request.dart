import 'package:equatable/equatable.dart';

class PolarFormRequest extends Equatable {
  final num real;
  final num imaginary;

  const PolarFormRequest({
    required this.real,
    required this.imaginary,
  });

  Map<String, dynamic> toJson() {
    return {
      'real': real,
      'imaginary': imaginary,
    };
  }

  @override
  List<Object> get props => [real, imaginary];
}
