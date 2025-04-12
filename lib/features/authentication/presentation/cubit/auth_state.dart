import 'package:cullinarium/features/authentication/data/models/auth_model.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final AuthModel? user;
  final String? error;
  final bool isResetEmailSent;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.error,
    this.isResetEmailSent = false,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    AuthModel? user,
    String? error,
    bool? isResetEmailSent,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      error: error,
      isResetEmailSent: isResetEmailSent ?? this.isResetEmailSent,
    );
  }
}
