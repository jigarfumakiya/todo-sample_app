import 'package:get_it/get_it.dart';
import 'package:todo_sample_app/app_cubit.dart';

final sl = GetIt.instance;

Future<void> init({bool isMock = true}) async {
  // Bloc
  sl.registerFactory(() => AppCubit());

  // sl.registerFactory(
  //   () => PriceTrackerCubit(sl()),
  // );
  //
  // // Use cases
  //
  // sl.registerLazySingleton(
  //   () => PriceTrackerUseCase(sl()),
  // );
  //
  // // Repository
  // sl.registerLazySingleton<PriceTrackerRepository>(
  //   () => PriceTrackerRepositoriesImpl(sl()),
  // );
  // sl.registerLazySingleton(() => SocketManager());
  //
  // //
  // // Data sources
  // sl.registerLazySingleton<PriceTrackerRemoteSource>(
  //   () => PriceTrackerRemoteSourceImpl(sl()),
  // );
  //
  // //
  // final dio = Dio();
  // dio.interceptors.add(LogInterceptor(
  //   requestHeader: true,
  //   responseBody: true,
  //   requestBody: true,
  //   request: true,
  //   error: true,
  // ));
  // sl.registerLazySingleton<Dio>(() => dio);
}
