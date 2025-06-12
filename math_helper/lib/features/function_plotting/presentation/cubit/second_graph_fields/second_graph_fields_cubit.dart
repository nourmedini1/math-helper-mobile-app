import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'second_graph_fields_state.dart';

class SecondGraphFieldsCubit extends Cubit<SecondGraphFieldsState> {
  SecondGraphFieldsCubit() : super(SecondGraphFieldsReady());

  void checkAllFieldsReady(bool allFieldsReady) {
    if (allFieldsReady) {
      emit(SecondGraphFieldsReady());
    } else {
      emit(SecondGraphFieldsMissing());
    }
  }
  void reset() {
    emit(SecondGraphFieldsMissing());
  }
}
