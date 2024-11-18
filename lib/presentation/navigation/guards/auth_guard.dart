import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/data/remote/auth_service.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthService _authService;

  AuthGuard(this._authService);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // if (_authService.isLoggedIn) {
    //   resolver.next(true);
    // } else {
    //   router.push(const LoginRoute());
    // }
  }
}