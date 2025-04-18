import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cullinarium/core/navigation/app_router.dart';
import 'package:cullinarium/features/authentication/auth_injection.dart';
import 'package:cullinarium/features/profile/profile_injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> injections() async {
  sl.registerLazySingleton<AppRouter>(() => AppRouter());

  setupFirebaseService();

  await authInjection();

  profileInjection();
}

void setupFirebaseService() {
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  // sl.registerLazySingleton<StorageService>(() => StorageService());
  // sl.registerLazySingleton<MessagingService>(() => MessagingService());
}
