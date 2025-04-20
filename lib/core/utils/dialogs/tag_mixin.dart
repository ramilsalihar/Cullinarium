import 'package:flutter/material.dart';

mixin TagMixin {
  Future<String?> showAddTagDialog({
    required BuildContext context,
    String title = 'Добавить тег',
  }) {
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Введите тег'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              final value = controller.text.trim();
              Navigator.pop(context, value.isEmpty ? null : value);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
