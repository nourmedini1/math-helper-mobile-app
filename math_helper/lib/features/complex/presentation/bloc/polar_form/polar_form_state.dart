part of 'polar_form_bloc.dart';

@immutable
sealed class PolarFormState {}

final class PolarFormInitial extends PolarFormState {}

final class PolarFormLoading extends PolarFormState {}

final class PolarFormOperationSuccess extends PolarFormState {
  final PolarFormResponse response;

  PolarFormOperationSuccess({required this.response});
}

final class PolarFormFailure extends PolarFormState {
  final String message;

  PolarFormFailure({required this.message});
}
