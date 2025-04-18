import 'package:cullinarium/core/di/injections.dart';
import 'package:cullinarium/features/authentication/data/datasource/remote/auth_service.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';

Future<void> authInjection() async {
  // Register DataSource
  sl.registerLazySingleton<AuthService>(() => AuthService(
        sl(),
        sl(),
      ));

  // Register Cubit
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      authService: sl<AuthService>(),
    )..loadInitialData(),
  );
}
