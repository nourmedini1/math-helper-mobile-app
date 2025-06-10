import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'symbolic_sum_fields_state.dart';

class SymbolicSumFieldsCubit extends Cubit<SymbolicSumFieldsState> {
  SymbolicSumFieldsCubit() : super(SymbolicSumFieldsMissing());

  void checkAllFieldsReady(bool isFilled) {
    if (isFilled) {
      emit(SymbolicSumFieldsReady());
    } else {
      emit(SymbolicSumFieldsMissing());
    }
  }
  void reset() {
    emit(SymbolicSumFieldsMissing());
  }
}
