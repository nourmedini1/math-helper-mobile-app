import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'addition_cubit_state.dart';

class AdditionCubit extends Cubit<AdditionState> {
  AdditionCubit() : super(AdditionFieldsMissing());

   void checkFieldsReady(bool allFilled) {

    if (allFilled) {
      emit(AdditionFieldsReady());
    } else {
      emit(AdditionFieldsMissing());
    }
  }
  void reset() {
    emit(AdditionFieldsMissing());
  }

}

 


