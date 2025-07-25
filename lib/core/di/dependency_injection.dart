import 'package:axis_assessment/features/people/data/repository/people_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/people/domain/repository/people_repository.dart';
import '../../features/people/presentations/cubit/people_cubit.dart';
import '../networking/api_services.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = await DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // People Repository
  getIt.registerLazySingleton<PeopleRepository>(
        () => PeopleRepositoryImpl(getIt<ApiService>()),
  );

  // People Cubit
  getIt.registerFactory<PeopleCubit>(
        () => PeopleCubit(getIt<PeopleRepository>()),
  );
}