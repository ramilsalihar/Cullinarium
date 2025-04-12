import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/features/authentication/data/auth_service.dart';

class UserGuard extends AutoRouteGuard {
  final AuthService _authService;

  UserGuard(this._authService);

  @override
  Future<bool> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    // final currentUser = await _authService.getCurrentUser();
    //
    // if (currentUser?.role != UserRole.customer) {
    //   // Redirect to appropriate screen or show error
    //   router.push(const AuthRoute());
    //   return false;
    // }

    return true;
  }
}
