import 'package:cullinarium/features/profile/data/models/profile_model.dart';

class AuthorModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final ProfileModel? profile;
  final List<String>? courses;
  final List<String>? recipes;

  const AuthorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    this.profile,
    this.courses,
    this.recipes,
  });
}
