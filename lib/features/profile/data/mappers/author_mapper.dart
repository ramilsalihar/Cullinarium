import 'package:cullinarium/features/profile/data/models/author_model.dart';
import 'package:cullinarium/features/profile/data/mappers/profile_mapper.dart';

class AuthorMapper {
  static Map<String, dynamic> toJson(AuthorModel author) {
    return {
      'id': author.id,
      'name': author.name,
      'email': author.email,
      'role': author.role,
      'createdAt': author.createdAt,
      'profile':
          author.profile != null ? ProfileMapper.toJson(author.profile!) : null,
      'courses': author.courses,
      'recipes': author.recipes,
    };
  }

  static AuthorModel fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      createdAt: json['createdAt'],
      profile: ProfileMapper.fromJson(json['profile']),
      courses: (json['courses'] as List<dynamic>).cast<String>(),
      recipes: (json['recipes'] as List<dynamic>).cast<String>(),
    );
  }
}
