import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'symbolic_partial_derivative_state.dart';

class SymbolicPartialDerivativeCubit extends Cubit<SymbolicPartialDerivativeState> {
  SymbolicPartialDerivativeCubit() : super(SymbolicPartialDerivativeOff());
  void turnOn() {
    emit(SymbolicPartialDerivativeOn());
  }
  void turnOff() {
    emit(SymbolicPartialDerivativeOff());
  }
  bool isOn() {
    return state is SymbolicPartialDerivativeOn;
  }
  bool isOff() {
    return state is SymbolicPartialDerivativeOff;
  }

  void toggle() {
    if (isOn()) {
      turnOff();
    } else {
      turnOn();
    }
  }
}
