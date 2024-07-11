part of 'polar_form_bloc.dart';

@immutable
sealed class PolarFormEvent extends Equatable {
  const PolarFormEvent();
}

final class PolarFormRequested extends PolarFormEvent {
  final PolarFormRequest request;
  const PolarFormRequested({required this.request});

  @override
  List<Object> get props => [request];
}

final class PolarFormReset extends PolarFormEvent {
  const PolarFormReset();

  @override
  List<Object> get props => [];
}
