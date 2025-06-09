import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'triple_fields_state.dart';

class TripleFieldsCubit extends Cubit<TripleFieldsState> {
  TripleFieldsCubit() : super(TripleFieldsMissing());
  void checkFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(TripleFieldsReady());
    } else {
      emit(TripleFieldsMissing());
    }
  }
  void reset() {
    emit(TripleFieldsMissing());
  }
}
