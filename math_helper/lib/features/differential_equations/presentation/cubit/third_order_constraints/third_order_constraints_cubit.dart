import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'third_order_constraints_state.dart';

class ThirdOrderConstraintsCubit extends Cubit<ThirdOrderConstraintsState> {
  ThirdOrderConstraintsCubit() : super(ThirdOrderConstraintsInitial());

  void updateFirstConstraints(List<String> firstConstraints) {
    final currentState = state as ThirdOrderConstraintsInitial;
    emit(ThirdOrderConstraintsInitial(
      firstConstraints: firstConstraints,
      secondConstraints: currentState.secondConstraints,
      thirdConstraints: currentState.thirdConstraints,
      fourthConstraints: currentState.fourthConstraints,
      text: 'Initial Conditions : {(${firstConstraints[0]},${firstConstraints[1]}), (${currentState.secondConstraints[0]},${currentState.secondConstraints[1]}), (${currentState.thirdConstraints[0]},${currentState.thirdConstraints[1]}), (${currentState.fourthConstraints[0]},${currentState.fourthConstraints[1]})}',
    ));
  }

  void updateSecondConstraints(List<String> secondConstraints) {
    final currentState = state as ThirdOrderConstraintsInitial;
    emit(ThirdOrderConstraintsInitial(
      firstConstraints: currentState.firstConstraints,
      secondConstraints: secondConstraints,
      thirdConstraints: currentState.thirdConstraints,
      fourthConstraints: currentState.fourthConstraints,
      text: 'Initial Conditions : {(${currentState.firstConstraints[0]},${currentState.firstConstraints[1]}), (${secondConstraints[0]},${secondConstraints[1]}), (${currentState.thirdConstraints[0]},${currentState.thirdConstraints[1]}), (${currentState.fourthConstraints[0]},${currentState.fourthConstraints[1]})}',
    ));
  }

  void updateThirdConstraints(List<String> thirdConstraints) {
    final currentState = state as ThirdOrderConstraintsInitial;
    emit(ThirdOrderConstraintsInitial(
      firstConstraints: currentState.firstConstraints,
      secondConstraints: currentState.secondConstraints,
      thirdConstraints: thirdConstraints,
      fourthConstraints: currentState.fourthConstraints,
      text: 'Initial Conditions : {(${currentState.firstConstraints[0]},${currentState.firstConstraints[1]}), (${currentState.secondConstraints[0]},${currentState.secondConstraints[1]}), (${thirdConstraints[0]},${thirdConstraints[1]}), (${currentState.fourthConstraints[0]},${currentState.fourthConstraints[1]})}',
    ));
  }

  void updateFourthConstraints(List<String> fourthConstraints) {
    final currentState = state as ThirdOrderConstraintsInitial;
    emit(ThirdOrderConstraintsInitial(
      firstConstraints: currentState.firstConstraints,
      secondConstraints: currentState.secondConstraints,
      thirdConstraints: currentState.thirdConstraints,
      fourthConstraints: fourthConstraints,
      text: 'Initial Conditions : {(${currentState.firstConstraints[0]},${currentState.firstConstraints[1]}), (${currentState.secondConstraints[0]},${currentState.secondConstraints[1]}), (${currentState.thirdConstraints[0]},${currentState.thirdConstraints[1]}), (${fourthConstraints[0]},${fourthConstraints[1]})}',
    ));
  }
  void resetText() {
    emit(ThirdOrderConstraintsInitial());
  }
}
