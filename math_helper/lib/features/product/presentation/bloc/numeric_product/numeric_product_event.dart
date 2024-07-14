part of 'numeric_product_bloc.dart';

@immutable
sealed class NumericProductEvent extends Equatable {
  const NumericProductEvent();
}

final class NumericProductRequested extends NumericProductEvent {
  final ProductRequest request;
  const NumericProductRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class NumericProductReset extends NumericProductEvent {
  const NumericProductReset();
  @override
  List<Object> get props => [];
}
