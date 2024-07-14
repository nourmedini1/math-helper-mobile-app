import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/features/product/data/models/product_request.dart';
import 'package:math_helper/features/product/data/models/product_response.dart';
import 'package:math_helper/features/product/domain/usecases/numeric_product_usecase.dart';
import 'package:meta/meta.dart';

part 'numeric_product_event.dart';
part 'numeric_product_state.dart';

class NumericProductBloc
    extends Bloc<NumericProductEvent, NumericProductState> {
  final NumericProductUsecase numericProductUsecase;
  NumericProductBloc({required this.numericProductUsecase})
      : super(NumericProductInitial()) {
    on<NumericProductEvent>((event, emit) async {
      if (event is NumericProductReset) {
        emit(NumericProductInitial());
      }
      if (event is NumericProductRequested) {
        emit(NumericProductLoading());
        final result = await numericProductUsecase(event.request);
        result.fold(
          (failure) => emit(NumericProductFailure(message: failure.message)),
          (response) => emit(NumericProductSuccess(response: response)),
        );
      }
    }, transformer: droppable());
  }
}
