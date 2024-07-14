import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:math_helper/features/integrals/data/models/integral_request.dart';
import 'package:math_helper/features/integrals/data/models/integral_response.dart';
import 'package:math_helper/features/integrals/domain/usecases/triple_integral_usecase.dart';
import 'package:meta/meta.dart';

part 'triple_integral_event.dart';
part 'triple_integral_state.dart';

class TripleIntegralBloc
    extends Bloc<TripleIntegralEvent, TripleIntegralState> {
  final TripleIntegralUsecase tripleIntegralUsecase;
  TripleIntegralBloc({required this.tripleIntegralUsecase})
      : super(TripleIntegralInitial()) {
    on<TripleIntegralEvent>((event, emit) async {
      if (event is TripleIntegralReset) {
        emit(TripleIntegralInitial());
      } else if (event is TripleIntegralRequested) {
        emit(TripleIntegralLoading());
        final result = await tripleIntegralUsecase(event.request);
        result.fold(
          (failure) => emit(TripleIntegralFailure(message: failure.message)),
          (response) => emit(TripleIntegralSuccess(response: response)),
        );
      }
    }, transformer: droppable());
  }
}
