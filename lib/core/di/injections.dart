import 'package:cullinarium/core/navigation/app_router.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void injections() {

  sl.registerLazySingleton<AppRouter>(() => AppRouter());
}