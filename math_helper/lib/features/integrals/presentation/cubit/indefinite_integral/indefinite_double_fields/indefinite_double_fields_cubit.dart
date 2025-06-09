import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'indefinite_double_fields_state.dart';

class IndefiniteDoubleFieldsCubit extends Cubit<IndefiniteDoubleFieldsState> {
  IndefiniteDoubleFieldsCubit() : super(IndefiniteDoubleFieldsMissing());

  void checkFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(IndefiniteDoubleFieldsReady());
    } else {
      emit(IndefiniteDoubleFieldsMissing());
    }
  }
  void reset() {
    emit(IndefiniteDoubleFieldsMissing());
  }
}
