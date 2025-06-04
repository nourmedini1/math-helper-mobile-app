import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'polar_form_state.dart';

class PolarFormCubit extends Cubit<PolarFormCubitState> {
  PolarFormCubit() : super(PolarFormFieldsMissing());
  void checkFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(PolarFormFieldsReady());
    } else {
      emit(PolarFormFieldsMissing());
    }
  }
  void reset() {

    emit(PolarFormFieldsMissing());
  }


}
