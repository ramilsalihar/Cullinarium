import 'package:cullinarium/features/profile/data/models/author_model.dart';
import 'package:cullinarium/features/profile/data/models/profile_model.dart';
import 'package:flutter/material.dart';

class AuthorProfileForm extends StatefulWidget {
  final AuthorModel author;
  final Function(Map<String, dynamic>) onSave;

  const AuthorProfileForm({
    Key? key,
    required this.author,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AuthorProfileForm> createState() => _AuthorProfileFormState();
}

class _AuthorProfileFormState extends State<AuthorProfileForm> {
  // For new users, we start in edit mode
  late bool _isEditing;
  late TextEditingController _descriptionController;
  late TextEditingController _jobExperienceController;
  late TextEditingController _locationController;
  late TextEditingController _phoneController;
  late TextEditingController _instagramController;
  late List<String> _selectedCategories;
  late List<String> _selectedLanguages;

  @override
  void initState() {
    super.initState();
    // If profile is null, we're dealing with a new user
    _isEditing = widget.author.profile == null;
    _initControllers();
  }

  void _initControllers() {
    final ProfileModel? profile = widget.author.profile;
    _descriptionController =
        TextEditingController(text: profile?.description ?? '');
    _jobExperienceController =
        TextEditingController(text: profile?.jobExperience?.toString() ?? '');
    _locationController = TextEditingController(text: profile?.location ?? '');
    _phoneController = TextEditingController(text: profile?.phoneNumber ?? '');
    _instagramController =
        TextEditingController(text: profile?.instagram ?? '');
    _selectedCategories = profile?.categories?.toList() ?? [];
    _selectedLanguages = profile?.languages?.toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.author.profile == null
                    ? 'Complete Your Profile'
                    : 'Your Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (widget.author.profile !=
                  null) // Only show edit/cancel buttons for existing profiles
                IconButton(
                  icon: Icon(_isEditing ? Icons.close : Icons.edit),
                  onPressed: () {
                    setState(() {
                      if (_isEditing) {
                        _isEditing = false;
                        _initControllers(); // Reset controllers to original values
                      } else {
                        _isEditing = true;
                      }
                    });
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _isEditing ? _buildEditForm() : _buildProfileDetails(),
          ),
          if (_isEditing)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Text(widget.author.profile == null
                    ? 'SAVE PROFILE'
                    : 'UPDATE PROFILE'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    final profile = widget.author.profile;

    // This should never happen now because we start in edit mode for new users
    if (profile == null) {
      return _buildEditForm();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (profile.rating != null) _buildRatingSection(profile.rating!),
        const SizedBox(height: 16),
        _buildSectionTitle('About'),
        _buildInfoRow('Description', profile.description),
        const SizedBox(height: 16),
        _buildSectionTitle('Professional Info'),
        _buildInfoRow('Experience', '${profile.jobExperience} years'),
        _buildInfoRow('Location', profile.location),
        const SizedBox(height: 16),
        _buildSectionTitle('Categories'),
        if (profile.categories != null && profile.categories!.isNotEmpty)
          _buildChipsList(profile.categories!)
        else
          const Text('No categories specified'),
        const SizedBox(height: 16),
        _buildSectionTitle('Languages'),
        if (profile.languages != null && profile.languages!.isNotEmpty)
          _buildChipsList(profile.languages!)
        else
          const Text('No languages specified'),
        const SizedBox(height: 16),
        _buildSectionTitle('Contact Information'),
        _buildInfoRow('Phone', profile.phoneNumber ?? 'Not provided'),
        if (profile.instagram != null && profile.instagram!.isNotEmpty)
          _buildInfoRow('Instagram', '@${profile.instagram}'),
        const SizedBox(height: 24),
        _buildRecipeAndCourseCount(),
      ],
    );
  }

  Widget _buildEditForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('About'),
        TextFormField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Tell us about yourself and your culinary background',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a description';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildSectionTitle('Professional Info'),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _jobExperienceController,
                decoration: const InputDecoration(
                  labelText: 'Experience (years)',
                  hintText: 'e.g., 5',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Enter a number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'e.g., New York, USA',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionTitle('Categories'),
        const Text(
          'Select the cuisine categories you specialize in',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        _buildCategorySelector(),
        const SizedBox(height: 16),
        _buildSectionTitle('Languages'),
        const Text(
          'Select languages you speak',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        _buildLanguageSelector(),
        const SizedBox(height: 16),
        _buildSectionTitle('Contact Information'),
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            hintText: 'e.g., +1 555-123-4567',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _instagramController,
          decoration: const InputDecoration(
            labelText: 'Instagram Handle',
            hintText: 'yourusername',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.camera_alt),
            prefixText: '@',
          ),
        ),
        const SizedBox(height: 16),
        if (widget.author.profile == null)
          const Text(
            'Complete your profile to start sharing recipes and courses!',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }

  Widget _buildRatingSection(double rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < rating.floor() ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 24,
            );
          }),
        ),
        const SizedBox(width: 8),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildRecipeAndCourseCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCountCard(
          icon: Icons.restaurant_menu,
          count: widget.author.recipes?.length ?? 0,
          label: 'Recipes',
        ),
        _buildCountCard(
          icon: Icons.school,
          count: widget.author.courses?.length ?? 0,
          label: 'Courses',
        ),
      ],
    );
  }

  Widget _buildCountCard({
    required IconData icon,
    required int count,
    required String label,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildChipsList(List<String> items) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        return Chip(
          label: Text(item),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        );
      }).toList(),
    );
  }

  Widget _buildCategorySelector() {
    // This is a simplified example - in a real app, you might want to
    // fetch these categories from an API or database
    final availableCategories = [
      'Italian',
      'Chinese',
      'Mexican',
      'Indian',
      'Japanese',
      'French',
      'Thai',
      'American',
      'Mediterranean',
      'Desserts',
      'Healthy',
      'Vegan'
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: availableCategories.map((category) {
        final isSelected = _selectedCategories.contains(category);
        return FilterChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedCategories.add(category);
              } else {
                _selectedCategories.remove(category);
              }
            });
          },
          selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
          checkmarkColor: Theme.of(context).primaryColor,
        );
      }).toList(),
    );
  }

  Widget _buildLanguageSelector() {
    // Similarly, these could come from a database or API
    final availableLanguages = [
      'English',
      'Spanish',
      'French',
      'Italian',
      'German',
      'Chinese',
      'Japanese',
      'Russian',
      'Arabic',
      'Hindi',
      'Portuguese'
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: availableLanguages.map((language) {
        final isSelected = _selectedLanguages.contains(language);
        return FilterChip(
          label: Text(language),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedLanguages.add(language);
              } else {
                _selectedLanguages.remove(language);
              }
            });
          },
          selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
          checkmarkColor: Theme.of(context).primaryColor,
        );
      }).toList(),
    );
  }

  void _saveProfile() {
    // Basic validation
    if (_descriptionController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _jobExperienceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final data = {
      'description': _descriptionController.text,
      'jobExperience': int.tryParse(_jobExperienceController.text) ?? 0,
      'location': _locationController.text,
      'phoneNumber': _phoneController.text,
      'instagram': _instagramController.text,
      'categories': _selectedCategories,
      'languages': _selectedLanguages,
    };

    widget.onSave(data);

    // Only toggle edit mode if we already had a profile
    if (widget.author.profile != null) {
      setState(() {
        _isEditing = false;
      });
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _jobExperienceController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _instagramController.dispose();
    super.dispose();
  }
}
