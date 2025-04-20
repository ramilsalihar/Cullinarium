import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipOval(
        child: Center(
          child: Text(
            'E',
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: 50,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
