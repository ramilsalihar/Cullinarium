// chef_profile_form.dart
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:flutter/material.dart';

class ChefProfileForm extends StatefulWidget {
  final ChefModel chef;
  final Function(Map<String, dynamic>) onSave;

  const ChefProfileForm({
    super.key,
    required this.chef,
    required this.onSave,
  });

  @override
  State<ChefProfileForm> createState() => _ChefProfileFormState();
}

class _ChefProfileFormState extends State<ChefProfileForm> {
  late TextEditingController _specialtyController;
  late TextEditingController _experienceController;
  late List<String> _selectedCuisines;

  @override
  void initState() {
    super.initState();
    _specialtyController = TextEditingController(
      text: widget.chef.profile?.description ?? '',
    );
    _experienceController = TextEditingController(
      text: widget.chef.profile?.description ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Chef Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _specialtyController,
          decoration: InputDecoration(
            labelText: 'Specialty',
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _experienceController,
          decoration: InputDecoration(
            labelText: 'Experience',
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 15),
        // Cuisine selection widget would go here
        // This would be a custom widget for multi-select
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _saveProfile,
          child: const Text('Save Profile'),
        ),
      ],
    );
  }

  void _saveProfile() {
    final data = {
      'specialty': _specialtyController.text,
      'experience': _experienceController.text,
      'cuisines': _selectedCuisines,
    };
    widget.onSave(data);
  }

  @override
  void dispose() {
    _specialtyController.dispose();
    _experienceController.dispose();
    super.dispose();
  }
}
