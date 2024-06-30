import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:math_helper/features/product/data/models/product_request.dart';
import 'package:math_helper/features/product/data/models/product_response.dart';
import 'package:math_helper/features/product/domain/usecases/symbolic_product_usecase.dart';
import 'package:meta/meta.dart';

part 'symbolic_product_event.dart';
part 'symbolic_product_state.dart';

class SymbolicProductBloc
    extends Bloc<SymbolicProductEvent, SymbolicProductState> {
  final SymbolicProductUsecase symbolicProductUsecase;
  SymbolicProductBloc({required this.symbolicProductUsecase})
      : super(SymbolicProductInitial()) {
    on<SymbolicProductEvent>((event, emit) async {
      emit(SymbolicProductLoading());
      final result = await symbolicProductUsecase(event.request);
      result.fold(
        (failure) => emit(SymbolicProductFailure(message: failure.message)),
        (response) => emit(SymbolicProductSuccess(response: response)),
      );
    }, transformer: droppable());
  }
}
