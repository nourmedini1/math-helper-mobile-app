part of 'symbolic_product_bloc.dart';

@immutable
sealed class SymbolicProductState {}

final class SymbolicProductInitial extends SymbolicProductState {}

final class SymbolicProductLoading extends SymbolicProductState {}

final class SymbolicProductSuccess extends SymbolicProductState {
  final ProductResponse response;

  SymbolicProductSuccess({required this.response});
}

final class SymbolicProductFailure extends SymbolicProductState {
  final String message;

  SymbolicProductFailure({required this.message});
}
