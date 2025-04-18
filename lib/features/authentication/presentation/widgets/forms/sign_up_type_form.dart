import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/features/authentication/presentation/widgets/role_card.dart';
import 'package:flutter/material.dart';

class SignUpTypeForm extends StatelessWidget {
  const SignUpTypeForm({super.key, required this.onRoleSelected});

  final Function(String role) onRoleSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: kToolbarHeight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.router.back(),
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: kToolbarHeight),
          Text(
            'Выберите роль',
            style: theme.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Укажите, как вы планируете использовать наше приложение',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 32),
          RoleCard(
            title: 'Пользователь',
            description: 'Просматривайте шеф-поваров и курсы по кулинарии',
            icon: Icons.person,
            onTap: () => onRoleSelected('user'),
          ),
          const SizedBox(height: 16),
          RoleCard(
            title: 'Шеф-повар',
            description: 'Продвигайте свои услуги и находите клиентов',
            icon: Icons.restaurant,
            onTap: () => onRoleSelected('chef'),
          ),
          const SizedBox(height: 16),
          RoleCard(
            title: 'Автор',
            description: 'Публикуйте курсы и делитесь знаниями',
            icon: Icons.book,
            onTap: () => onRoleSelected('author'),
          ),
        ],
      ),
    );
  }
}
