import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_sample_app/app_cubit.dart';
import 'package:todo_sample_app/core/network/dio_data_source.dart';
import 'package:todo_sample_app/core/network/dio_service.dart';
import 'package:todo_sample_app/core/network/refresh_token_usecase.dart';

final sl = GetIt.instance;

Future<void> init({bool isMock = true}) async {
  // Bloc
  sl.registerFactory(() => AppCubit());

  //? Service
  sl.registerLazySingleton(
    () => DioService(dioDataSource: sl(), refreshTokenUseCase: sl()),
  );

  //? Use cases
  sl.registerLazySingleton(
    () => RefreshTokenUseCase(sl()),
  );

  //? Repository

  // sl.registerLazySingleton<PriceTrackerRepository>(
  //   () => PriceTrackerRepositoriesImpl(sl()),
  // );
  // sl.registerLazySingleton(() => SocketManager());
  //
  // //

  //? Data sources
  sl.registerLazySingleton<DioDataSource>(
    () => DioDataSourceImpl(sl()),
  );

  //? Network
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(
    requestHeader: true,
    responseBody: true,
    requestBody: true,
    request: true,
    error: true,
  ));
  sl.registerLazySingleton<Dio>(() => dio);
}
