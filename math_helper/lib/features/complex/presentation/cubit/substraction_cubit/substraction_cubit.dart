import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'substraction_cubit_state.dart';

class SubstractionCubit extends Cubit<SubstractionState> {
  SubstractionCubit() : super(SubstractionFieldsMissing());

  void checkFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(SubstractionFieldsReady());
    } else {
      emit(SubstractionFieldsMissing());
    }
  }
  void reset() {
    emit(SubstractionFieldsMissing());
  }
}
