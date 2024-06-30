import 'package:equatable/equatable.dart';

class SumResponse extends Equatable {
  final String product;
  final String result;
  final bool convergent;

  const SumResponse({
    required this.product,
    required this.result,
    required this.convergent,
  });

  factory SumResponse.fromJson(Map<String, dynamic> json) {
    return SumResponse(
      product: json['product'],
      result: json['result'],
      convergent: json['convergent'],
    );
  }

  @override
  List<Object?> get props => [product, result, convergent];
}
