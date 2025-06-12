import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'first_graph_fields_state.dart';

class FirstGraphFieldsCubit extends Cubit<FirstGraphFieldsState> {
  FirstGraphFieldsCubit() : super(FirstGraphFieldsReady());

  void checkAllFieldsReady(bool allFieldsReady) {
    if (allFieldsReady) {
      emit(FirstGraphFieldsReady());
    } else {
      emit(FirstGraphFieldsMissing());
    }
  }
  void reset() {
    emit(FirstGraphFieldsMissing());
  }
}
