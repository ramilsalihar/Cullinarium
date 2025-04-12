import 'package:cullinarium/features/authentication/data/models/auth_model.dart';

class AuthMapper {
  static Map<String, dynamic> toJson(AuthModel data) {
    return {
      'id': data.id,
      'name': data.name,
      'email': data.email,
      'role': data.type,
    };
  }

  static AuthModel fromJson(Map<String, dynamic> data) {
    return AuthModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      type: data['role'],
    );
  }
}
