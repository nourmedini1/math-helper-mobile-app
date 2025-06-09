import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'first_order_constraints_text_state.dart';

class FirstOrderConstraintsTextCubit extends Cubit<FirstOrderConstraintsTextState> {
  FirstOrderConstraintsTextCubit() : super(FirstOrderConstraintsTextInitial());

  void updateFirstConstraints(List<String> firstConstraints) {
    final currentState = state as FirstOrderConstraintsTextInitial;
    emit(currentState.copyWith(
      firstContraints: firstConstraints,
      text: 'Initial Conditions : {(${firstConstraints[0]},${firstConstraints[1]}), (${currentState.secondContraints[0]},${currentState.secondContraints[1]})}',
    ));
  }
  void updateSecondConstraints(List<String> secondConstraints) {
    final currentState = state as FirstOrderConstraintsTextInitial;
    emit(currentState.copyWith(
      secondContraints: secondConstraints,
      text: 'Initial Conditions : {(${currentState.firstContraints[0]},${currentState.firstContraints[1]}), (${secondConstraints[0]},${secondConstraints[1]})}',
    ));
  }
  void resetText() {
    emit(FirstOrderConstraintsTextInitial());
  }
}
