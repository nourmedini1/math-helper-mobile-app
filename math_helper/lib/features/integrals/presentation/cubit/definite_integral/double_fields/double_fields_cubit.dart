import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'double_fields_state.dart';

class DoubleFieldsCubit extends Cubit<DoubleFieldsState> {
  DoubleFieldsCubit() : super(DoubleFieldsMissing());

  void checkFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(DoubleFieldsReady());
    } else {
      emit(DoubleFieldsMissing());
    }
  }
  void reset() {
    emit(DoubleFieldsMissing());
  }
}
