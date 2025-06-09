import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'indefinite_single_fields_state.dart';

class IndefiniteSingleFieldsCubit extends Cubit<IndefiniteSingleFieldsState> {
  IndefiniteSingleFieldsCubit() : super(IndefiniteSingleFieldsMissing());

  void checkFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(IndefiniteSingleFieldsReady());
    } else {
      emit(IndefiniteSingleFieldsMissing());
    }
  }
  void reset() {
    emit(IndefiniteSingleFieldsMissing());
  }
}
