import 'package:equatable/equatable.dart';

class ProductResponse extends Equatable {
  final String product;
  final String result;
  final bool convergent;

  const ProductResponse({
    required this.product,
    required this.result,
    required this.convergent,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      product: json['product'],
      result: json['result'],
      convergent: json['convergent'],
    );
  }

  @override
  List<Object?> get props => [product, result, convergent];
}
