import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'single_limit_fields_state.dart';

class SingleLimitFieldsCubit extends Cubit<SingleLimitFieldsState> {
  SingleLimitFieldsCubit() : super(SingleLimitFieldsMissing());

  void checkAllFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(SingleLimitFieldsReady());
    } else {
      emit(SingleLimitFieldsMissing());
    }
  }
  void reset() {
    emit(SingleLimitFieldsMissing());
  }
}
