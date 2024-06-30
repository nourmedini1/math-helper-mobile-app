part of 'numeric_product_bloc.dart';

@immutable
sealed class NumericProductState {}

final class NumericProductInitial extends NumericProductState {}

final class NumericProductLoading extends NumericProductState {}

final class NumericProductSuccess extends NumericProductState {
  final ProductResponse response;

  NumericProductSuccess({required this.response});
}

final class NumericProductFailure extends NumericProductState {
  final String message;

  NumericProductFailure({required this.message});
}
