import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/features/authentication/presentation/pages/login_page.dart';
import 'package:cullinarium/features/authentication/presentation/pages/signup_page.dart';
import 'package:cullinarium/features/authentication/presentation/splash_screen.dart';
import 'package:cullinarium/features/home/presentation/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
          // initial: true,
        ),
        AutoRoute(
          page: SignupRoute.page,
          path: '/signup',
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
        ),
      ];
}
