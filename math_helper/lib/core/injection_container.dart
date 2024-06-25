import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:math_helper/features/complex/data/api/complex_api.dart';
import 'package:math_helper/features/complex/data/repository/complex_repository_impl.dart';
import 'package:math_helper/features/complex/domain/repository/complex_repository.dart';
import 'package:math_helper/features/complex/domain/usecases/complex_addition_usecase.dart';
import 'package:math_helper/features/complex/domain/usecases/complex_multiplication_usecase.dart';
import 'package:math_helper/features/complex/domain/usecases/complex_substraction_usecase.dart';
import 'package:math_helper/features/complex/domain/usecases/polar_form_usecase.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_addition/complex_addition_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_multiplication/complex_multiplication_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/complex_substraction/complex_substraction_bloc.dart';
import 'package:math_helper/features/complex/presentation/bloc/polar_form/polar_form_bloc.dart';

final ic = GetIt.instance;

Future<void> init() async {
  //!core
  ic.registerLazySingleton(() => Connectivity());
  ic.registerLazySingleton(() => http.Client());

  //!features

  // complex
  ic.registerLazySingleton(() => ComplexApi(client: ic()));
  ic.registerLazySingleton<ComplexRepository>(
      () => ComplexRepositoryImpl(connectivity: ic(), complexApi: ic()));

  ic.registerLazySingleton(
      () => ComplexAdditionUsecase(complexRepository: ic()));
  ic.registerLazySingleton(
      () => ComplexMultiplicationUsecase(complexRepository: ic()));
  ic.registerLazySingleton(
      () => ComplexSubstractionUsecase(complexRepository: ic()));
  ic.registerLazySingleton(() => PolarFormUsecase(complexRepository: ic()));

  ic.registerFactory(() => ComplexAdditionBloc(complexAdditionUsecase: ic()));
  ic.registerFactory(
      () => ComplexSubstractionBloc(complexSubstractionUsecase: ic()));
  ic.registerFactory(
      () => ComplexMultiplicationBloc(complexMultiplicationUsecase: ic()));
  ic.registerFactory(() => PolarFormBloc(polarFormUsecase: ic()));
}
