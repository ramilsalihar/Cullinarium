import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/core/navigation/app_router.dart';
import 'package:cullinarium/features/authentication/presentation/widgets/user_switch.dart';
import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:cullinarium/core/widgets/forms/app_text_form_field.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            'assets/layout/background.png',
            height: size.height,
            width: size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: kToolbarHeight * 2.5,
            child: Image.asset(
              'assets/icons/app_logo.png',
              width: size.width * 0.7,
            ),
          ),
          Positioned(
            bottom: 0,
            child: loginContent(),
          ),
        ],
      ),
    );
  }

  Widget loginContent() {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Логин',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            const UserSwitch(),
            const SizedBox(height: 10),
            AppTextFormField(
              title: 'Email',
              controller: emailController,
            ),
            const SizedBox(height: 10),
            AppTextFormField(
              title: 'Пароль',
              controller: passwordController,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text('Забыли пароль?'),
            ),
            const SizedBox(height: 10),
            AppButton(
              title: 'Войти',
              color: Colors.black,
              onPressed: () {
                context.router.replaceAll([const HomeRoute()]);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Нет аккаунта?'),
                TextButton(
                  onPressed: () {
                    context.router.pushNamed('/signup');
                  },
                  child: const Text('Зарегистрироваться'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
