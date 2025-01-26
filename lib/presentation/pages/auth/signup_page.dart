import 'package:auto_route/annotations.dart';
import 'package:cullinarium/presentation/widgets/buttons/app_button.dart';
import 'package:cullinarium/presentation/widgets/forms/app_text_form_field.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            'assets/layout/signup_back.png',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 48,
              vertical: 24,
            ),
            child: Column(
              children: [
                const SizedBox(height: kToolbarHeight * 0.5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.7),
                Text(
                  'Регистрация',
                  style: theme.textTheme.labelLarge,
                ),
                const SizedBox(height: kToolbarHeight * 0.5),
                AppTextFormField(
                  title: 'Ф.И.О',
                  controller: nameController,
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  title: 'Email',
                  controller: emailController,
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  title: 'Пароль',
                  controller: passwordController,
                ),
                const SizedBox(height: 16),
                AppButton(
                  title: 'Создать',
                  color: Colors.black,
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
