import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'multiplication_cubit_state.dart';

class MultiplicationCubit extends Cubit<MultiplicationState> {
  MultiplicationCubit() : super(MultiplicationFieldsMissing());

  void checkFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(MultiplicationFieldsReady());
    } else {
      emit(MultiplicationFieldsMissing());
    }
  }
  
  void reset() {
    emit(MultiplicationFieldsMissing());
  }
}
