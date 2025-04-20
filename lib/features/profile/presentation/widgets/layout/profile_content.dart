import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cullinarium/features/profile/presentation/pages/personal_detail_page.dart';
import 'package:cullinarium/features/profile/presentation/widgets/buttons/logout_button.dart';
import 'package:cullinarium/features/profile/presentation/widgets/cards/personal_data_card.dart';
import 'package:cullinarium/features/profile/presentation/widgets/cards/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key, required this.state});

  final ProfileLoaded state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact info section
          const PersonalDataCard(),
          const SizedBox(height: 24),

          // Role-specific sections
          if (state.userType == 'chef') ...[
            _buildSectionHeader(context, 'Профессиональная информация'),
            const SizedBox(height: 8),
            ProfileCard(
              icon: Icons.restaurant,
              title: 'Кулинарные навыки',
              subtitle:
                  'Управление вашими специализациями и кулинарными стилями',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PersonalDetailPage(onSave: (data) {}),
                  ),
                );
              },
            ),
          ],

          if (state.userType == 'author') ...[
            _buildSectionHeader(context, 'Авторская информация'),
            const SizedBox(height: 8),
            ProfileCard(
              icon: Icons.book,
              title: 'Мои публикации',
              subtitle: 'Управление вашими курсами и содержанием',
              onTap: () {},
            ),
          ],

          const SizedBox(height: 24),

          // Settings section
          _buildSectionHeader(context, 'Настройки'),
          const SizedBox(height: 8),
          ProfileCard(
            icon: Icons.settings,
            title: 'Настройки приложения',
            subtitle: 'Язык, уведомления и предпочтения',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          ProfileCard(
            icon: Icons.shield,
            title: 'Конфиденциальность',
            subtitle: 'Управление данными и приватностью',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          ProfileCard(
            icon: Icons.help_outline,
            title: 'Помощь и поддержка',
            subtitle: 'Часто задаваемые вопросы и контакты',
            onTap: () {},
          ),
          const SizedBox(height: 32),

          // Logout button
          const LogoutButton(),
          const SizedBox(height: kToolbarHeight),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
      ),
    );
  }
}
