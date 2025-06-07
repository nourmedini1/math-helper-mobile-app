import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'taylor_series_fields_state.dart';

class TaylorSeriesFieldsCubit extends Cubit<TaylorSeriesFieldsState> {
  TaylorSeriesFieldsCubit() : super(TaylorSeriesFieldsMissing());

  void checkFieldsReady(bool allFilled) {
    if (allFilled) {
      emit(TaylorSeriesFieldsReady());
    } else {
      emit(TaylorSeriesFieldsMissing());
    }
  }
  void reset() {
    emit(TaylorSeriesFieldsMissing());
  }
}
