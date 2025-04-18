import 'package:cullinarium/core/di/injections.dart';
import 'package:cullinarium/features/profile/data/datasources/profile_service.dart';
import 'package:cullinarium/features/profile/data/repositories/profile_repository.dart';
import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';

void profileInjection() {
  // Datasources
  sl.registerLazySingleton(() => ProfileService());

  // Repositories
  sl.registerLazySingleton(() => ProfileRepository(sl()));

  // Cubits
  sl.registerFactory(() => ProfileCubit(
        authCubit: sl(),
        profileService: sl(),
      ));
}
