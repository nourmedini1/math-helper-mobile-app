part of 'numeric_product_bloc.dart';

@immutable
sealed class NumericProductEvent {
  final ProductRequest request;
  const NumericProductEvent({required this.request});
}
