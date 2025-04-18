import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_state.dart';
import 'package:cullinarium/features/authentication/presentation/pages/login_page.dart';
import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cullinarium/features/profile/presentation/pages/personal_detail_page.dart';
import 'package:cullinarium/features/profile/presentation/widgets/buttons/profile_button.dart';
import 'package:cullinarium/features/profile/presentation/widgets/layout/profile_background.dart';
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
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (isAuthenticated) {
          return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, pState) {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const ProfileBackground(),
                      Padding(
                        padding: const EdgeInsets.only(top: kToolbarHeight),
                        child: _buildProfileContent(context, pState),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileState state) {
    if (state is ProfileLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ProfileError) {
      return Center(child: Text('Error: ${state.message}'));
    }

    if (state is ProfileLoaded) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Role: ${state.userType}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              state.user.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text('Email: ${state.user.email}'),
            const SizedBox(height: 30),
            // _buildProfileForm(context, state),
            if (state.userType == 'author' || state.userType == 'chef')
              ProfileButton(
                title: 'Personal Data',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PersonalDetailPage(onSave: (data) {}),
                    ),
                  );
                },
              ),
            if (state.userType == 'chef')
              ProfileButton(
                title: 'Cooking Details',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PersonalDetailPage(onSave: (data) {}),
                    ),
                  );
                },
              ),
            ProfileButton(
              title: 'Settings',
              onPressed: () {},
            ),
            ProfileButton(
              title: 'Privacy',
              onPressed: () {},
            )
          ],
        ),
      );
    }

    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: kToolbarHeight),
        child: Text('Initializing profile...'),
      ),
    );
  }
}
