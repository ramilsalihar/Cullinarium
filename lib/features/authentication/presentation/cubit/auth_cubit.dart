import 'package:cullinarium/features/authentication/data/datasource/remote/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit({required AuthService authService})
      : _authService = authService,
        super(
          AuthState(isLoading: true),
        );

  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));

      // Check if user is already logged in
      final currentUser = await _authService.getCurrentUserData();

      if (currentUser != null) {
        emit(state.copyWith(
          isAuthenticated: true,
          user: currentUser,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isAuthenticated: false,
          isLoading: false,
        ));
      }
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String type,
  }) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final user = await _authService.signUp(
        email: email,
        password: password,
        name: name,
        type: type,
      );

      emit(state.copyWith(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      ));
    } catch (error) {
      print(' ----- ${error}');
      emit(state.copyWith(error: error.toString(), isLoading: false));
      emit(stableState.copyWith(isLoading: false, error: error.toString()));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final user = await _authService.signIn(
        email: email,
        password: password,
      );

      emit(state.copyWith(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      ));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
      emit(stableState.copyWith(isLoading: false, error: error.toString()));
    }
  }

  Future<void> resetPassword({required String email}) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true, error: null));

      await _authService.resetPassword(email: email);

      emit(state.copyWith(
        isResetEmailSent: true,
        isLoading: false,
      ));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
      emit(stableState.copyWith(isLoading: false, error: error.toString()));
    }
  }

  Future<void> signOut() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true, error: null));

      await _authService.signOut();

      emit(state.copyWith(
        isAuthenticated: false,
        user: null,
        isLoading: false,
      ));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
      emit(stableState.copyWith(isLoading: false, error: error.toString()));
    }
  }

  Future<void> deleteAccount() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true, error: null));

      await _authService.deleteAccount();

      emit(state.copyWith(
        isAuthenticated: false,
        user: null,
        isLoading: false,
      ));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
      emit(stableState.copyWith(isLoading: false, error: error.toString()));
    }
  }

  Future<void> updateProfile({String? name, String? type}) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true, error: null));

      await _authService.updateProfile(name: name, type: type);

      // Refresh the user data
      final updatedUser = await _authService.getCurrentUserData();

      if (updatedUser != null) {
        emit(state.copyWith(
          user: updatedUser,
          isLoading: false,
        ));
      } else {
        throw Exception("Failed to retrieve updated user data");
      }
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
      emit(stableState.copyWith(isLoading: false, error: error.toString()));
    }
  }
}
