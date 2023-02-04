import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_sample_app/app_cubit.dart';
import 'package:todo_sample_app/core/network/dio_data_source.dart';
import 'package:todo_sample_app/core/network/dio_service.dart';
import 'package:todo_sample_app/core/network/refresh_token_usecase.dart';
import 'package:todo_sample_app/feature/todo/data/datasources/todo_remote_source.dart';
import 'package:todo_sample_app/feature/todo/domain/repositories/todo_repositorie.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/bloc/todo_cubit.dart';

import '../../feature/todo/data/repositories/todo_repositorie_impl.dart';
import '../../feature/todo/domain/usecase/todo_usecase.dart';

final sl = GetIt.instance;

Future<void> init({bool isMock = true}) async {
  // Bloc
  sl.registerFactory(() => AppCubit());
  sl.registerFactory(() => TodoCubit(sl()));

  //? Service
  sl.registerLazySingleton(
    () => DioService(dioDataSource: sl(), refreshTokenUseCase: sl()),
  );

  //? Use cases
  sl.registerLazySingleton(
    () => TodoUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => RefreshTokenUseCase(sl()),
  );

  //? Repository

  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(sl()),
  );

  //? Data sources
  sl.registerLazySingleton<TodoRemoteSource>(
    () => TodoRemoteSourceImpl(dioService: sl()),
  );

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
