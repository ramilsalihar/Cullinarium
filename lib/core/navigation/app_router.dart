import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/presentation/pages/auth/login_page.dart';
import 'package:cullinarium/presentation/pages/auth/signup_page.dart';
import 'package:cullinarium/presentation/pages/auth/splash_screen.dart';
import 'package:cullinarium/presentation/pages/home_page.dart';

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
