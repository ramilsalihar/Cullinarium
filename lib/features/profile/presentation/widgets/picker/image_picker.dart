import 'dart:io';
import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ImagePicker extends StatefulWidget {
  final Function(File?) onImagePicked;

  const ImagePicker({
    super.key,
    required this.onImagePicked,
  });

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  File? _imageFile;

  // Simulate image picking
  void _pickImage() {
    // In a real app, you would use the image_picker package
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Сделать фото'),
                onTap: () {
                  Navigator.pop(context);
                  // Simulate camera capture
                  setState(() {
                    _imageFile = File(
                        'path/to/captured_image.jpg'); // Replace with actual file
                  });
                  widget.onImagePicked(_imageFile);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Выбрать из галереи'),
                onTap: () {
                  Navigator.pop(context);
                  // Simulate gallery pick
                  setState(() {
                    _imageFile = File(
                        'path/to/selected_image.jpg'); // Replace with actual file
                  });
                  widget.onImagePicked(_imageFile);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipOval(
                child: _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey.shade400,
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: _pickImage,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: _pickImage,
          child: const Text('Изменить фото'),
        ),
      ],
    );
  }
}
