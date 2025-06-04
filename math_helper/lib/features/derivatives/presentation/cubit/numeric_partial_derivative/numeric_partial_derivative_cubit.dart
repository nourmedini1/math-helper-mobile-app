import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'numeric_partial_derivative_state.dart';

class NumericPartialDerivativeCubit extends Cubit<NumericPartialDerivativeState> {
  NumericPartialDerivativeCubit() : super(NumericPartialDerivativeOff());
  void turnOn() {
    emit(NumericPartialDerivativeOn());
  }
  void turnOff() {
    emit(NumericPartialDerivativeOff());
  }
  bool isOn() {
    return state is NumericPartialDerivativeOn;
  }
  bool isOff() {
    return state is NumericPartialDerivativeOff;
  }
  void toggle() {
    if (isOn()) {
      turnOff();
    } else {
      turnOn();
    }
  }
}
