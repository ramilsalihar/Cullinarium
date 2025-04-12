import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/features/authentication/data/auth_service.dart';

class ChefGuard extends AutoRouteGuard {
  final AuthService _authService;

  ChefGuard(this._authService);

  @override
  Future<bool> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    // final currentUser = await _authService.getCurrentUser();
    //
    // if (currentUser?.role != UserRole.chef) {
    //   // Redirect to appropriate screen or show error
    //   router.push(const AuthRoute());
    //   return false;
    // }

    return true;
  }
}
