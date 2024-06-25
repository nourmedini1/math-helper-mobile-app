part of 'polar_form_bloc.dart';

@immutable
sealed class PolarFormEvent {
  final PolarFormRequest request;
  const PolarFormEvent({required this.request});
}
