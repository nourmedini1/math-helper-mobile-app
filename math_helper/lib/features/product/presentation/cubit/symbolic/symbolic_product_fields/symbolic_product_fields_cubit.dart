import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'symbolic_product_fields_state.dart';

class SymbolicProductFieldsCubit extends Cubit<SymbolicProductFieldsState> {
  SymbolicProductFieldsCubit() : super(SymbolicProductFieldsMissing());

  void checkAllFieldsReady(bool isFilled) {
    if (isFilled) {
      emit(SymbolicProductFieldsReady());
    } else {
      emit(SymbolicProductFieldsMissing());
    }
  }
  void reset() {
    emit(SymbolicProductFieldsMissing());
  }
}
