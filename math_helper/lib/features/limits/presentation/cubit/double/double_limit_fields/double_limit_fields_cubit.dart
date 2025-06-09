import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'double_limit_fields_state.dart';

class DoubleLimitFieldsCubit extends Cubit<DoubleLimitFieldsState> {
  DoubleLimitFieldsCubit() : super(DoubleLimitFieldsMissing());

  void checkAllFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(DoubleLimitFieldsReady());
    } else {
      emit(DoubleLimitFieldsMissing());
    }
  }

  void reset() {
    emit(DoubleLimitFieldsMissing());
  }
}
