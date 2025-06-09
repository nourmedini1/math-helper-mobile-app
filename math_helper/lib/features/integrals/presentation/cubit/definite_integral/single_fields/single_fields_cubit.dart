import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'single_fields_state.dart';

class SingleFieldsCubit extends Cubit<SingleFieldsState> {
  SingleFieldsCubit() : super(SingleFieldsMissing());

  void checkFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(SingleFieldsReady());
    } else {
      emit(SingleFieldsMissing());
    }
  }
  void reset() {
    emit(SingleFieldsMissing());
  }
}
