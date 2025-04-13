import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/core/navigation/app_router.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_state.dart';
import 'package:cullinarium/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        bool isAuthenticated = state.isAuthenticated;
        if (isAuthenticated) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${state.user?.name}'),
                  const SizedBox(height: 20),
                  Text('Role: ${state.user?.role}'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                      context.router.replaceAll([
                        const LoginRoute(),
                      ]);
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
