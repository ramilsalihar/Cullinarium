import 'package:auto_route/annotations.dart';
import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:cullinarium/features/authentication/presentation/widgets/forms/sign_up_form.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final PageController _pageController = PageController();

  String role = 'guest';

  void goToFormPage() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Page 1 - Buttons
          buildButtons(),

          // Page 2 - Registration form
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
              child: SignUpForm(
                role: role,
              )),
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Column(
      children: [
        const SizedBox(height: kToolbarHeight * 4),
        AppButton(
          title: 'User',
          onPressed: () {
            setState(() {
              role = 'user';
              goToFormPage();
            });
          },
        ),
        const SizedBox(height: 16),
        AppButton(
          title: 'Chef',
          onPressed: () {
            setState(() {
              role = 'chef';
              goToFormPage();
            });
          },
        ),
        const SizedBox(height: 16),
        AppButton(
          title: 'Author',
          onPressed: () {
            setState(() {
              role = 'author';
              goToFormPage();
            });
          },
        ),
      ],
    );
  }
}
