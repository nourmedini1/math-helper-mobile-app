import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'indefinite_triple_fields_state.dart';

class IndefiniteTripleFieldsCubit extends Cubit<IndefiniteTripleFieldsState> {
  IndefiniteTripleFieldsCubit() : super(IndefiniteTripleFieldsMissing());

  void checkFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(IndefiniteTripleFieldsReady());
    } else {
      emit(IndefiniteTripleFieldsMissing());
    }
  }
  void reset() {
    emit(IndefiniteTripleFieldsMissing());
  }
}
