part of 'symbolic_product_bloc.dart';

@immutable
sealed class SymbolicProductEvent {
  final ProductRequest request;
  const SymbolicProductEvent({required this.request});
}
