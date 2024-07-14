part of 'symbolic_product_bloc.dart';

@immutable
sealed class SymbolicProductEvent extends Equatable {
  const SymbolicProductEvent();
}

final class SymbolicProductRequested extends SymbolicProductEvent {
  final ProductRequest request;
  const SymbolicProductRequested({required this.request});
  @override
  List<Object> get props => [request];
}

final class SymbolicProductReset extends SymbolicProductEvent {
  const SymbolicProductReset();
  @override
  List<Object> get props => [];
}
