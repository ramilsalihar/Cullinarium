import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:cullinarium/core/widgets/forms/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_state.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, required this.role});

  final String role;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _signup() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().signUp(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
            role: widget.role,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.error != null) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state.isAuthenticated) {
          print('User authenticated: ${state.user!.name}');
          // Navigate to home or profile completion page
          // Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight * 0.5),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              const SizedBox(height: kToolbarHeight * 0.7),
              Text(
                'Register as ${widget.role}',
                style: theme.textTheme.labelLarge,
              ),
              const SizedBox(height: kToolbarHeight * 0.5),
              AppTextFormField(
                title: 'Ф.И.О',
                controller: nameController,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Пожалуйста, введите ваше Ф.И.О';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 16),
              AppTextFormField(
                title: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Пожалуйста, введите email';
                //   }
                //   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                //     return 'Пожалуйста, введите корректный email';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 16),
              AppTextFormField(
                title: 'Пароль',
                controller: passwordController,
                obscureText: true,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Пожалуйста, введите пароль';
                //   }
                //   if (value.length < 6) {
                //     return 'Пароль должен содержать минимум 6 символов';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 16),
              AppButton(
                title: state.isLoading ? 'Загрузка...' : 'Создать',
                color: Colors.black,
                onPressed: state.isLoading ? () {} : _signup,
              ),
            ],
          ),
        );
      },
    );
  }
}
