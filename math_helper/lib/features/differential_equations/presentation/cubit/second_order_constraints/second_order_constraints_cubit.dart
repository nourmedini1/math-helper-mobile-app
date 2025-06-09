import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'second_order_constraints_state.dart';

class SecondOrderConstraintsCubit extends Cubit<SecondOrderConstraintsState> {
  SecondOrderConstraintsCubit() : super(SecondOrderConstraintsInitial());

  void updateFirstConstraints(List<String> firstConstraints) {
    final currentState = state as SecondOrderConstraintsInitial;
    emit(currentState.copyWith(
      firstConstraints: firstConstraints,
      text: 'Initial Conditions : {(${firstConstraints[0]},${firstConstraints[1]}), (${currentState.secondConstraints[0]},${currentState.secondConstraints[1]}), (${currentState.thirdConstraints[0]},${currentState.thirdConstraints[1]})}',
    ));
  }

  void updateSecondConstraints(List<String> secondConstraints) {
    final currentState = state as SecondOrderConstraintsInitial;
    emit(currentState.copyWith(
      secondConstraints: secondConstraints,
      text: 'Initial Conditions : {(${currentState.firstConstraints[0]},${currentState.firstConstraints[1]}), (${secondConstraints[0]},${secondConstraints[1]}), (${currentState.thirdConstraints[0]},${currentState.thirdConstraints[1]})}',
    ));
  }

  void updateThirdConstraints(List<String> thirdConstraints) {
    final currentState = state as SecondOrderConstraintsInitial;
    emit(currentState.copyWith(
      thirdConstraints: thirdConstraints,
      text: 'Initial Conditions : {(${currentState.firstConstraints[0]},${currentState.firstConstraints[1]}), (${currentState.secondConstraints[0]},${currentState.secondConstraints[1]}), (${thirdConstraints[0]},${thirdConstraints[1]})}',
    ));
  }
  void resetText() {
    emit(SecondOrderConstraintsInitial());
  }
}
