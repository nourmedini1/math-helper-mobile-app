import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'triple_limit_fields_state.dart';

class TripleLimitFieldsCubit extends Cubit<TripleLimitFieldsState> {
  TripleLimitFieldsCubit() : super(TripleLimitFieldsMissing());

  void checkAllFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(TripleLimitFieldsReady());
    } else {
      emit(TripleLimitFieldsMissing());
    }
  }

  void reset() {
    emit(TripleLimitFieldsMissing());
  }
}
