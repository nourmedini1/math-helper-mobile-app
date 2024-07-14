part of 'numeric_derivative_bloc.dart';

@immutable
sealed class NumericDerivativeEvent extends Equatable {
  const NumericDerivativeEvent();
}

final class NumericDerivativeRequested extends NumericDerivativeEvent {
  final DerivativeRequest request;
  const NumericDerivativeRequested({required this.request});

  @override
  List<Object> get props => [request];
}

final class NumericDerivativeReset extends NumericDerivativeEvent {
  const NumericDerivativeReset();

  @override
  List<Object> get props => [];
}
