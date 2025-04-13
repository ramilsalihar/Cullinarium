import 'package:cullinarium/features/authentication/data/models/auth_model.dart';
import 'package:cullinarium/features/profile/data/models/author_model.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:cullinarium/features/profile/data/models/user_model.dart';

class AuthMapper {
  static Map<String, dynamic> toJson(AuthModel data) {
    return {
      'id': data.id,
      'name': data.name,
      'email': data.email,
      'role': data.role,
      'createdAt': data.createdAt,
    };
  }

  static AuthModel fromJson(Map<String, dynamic> data) {
    return AuthModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      role: data['role'],
      createdAt: data['createdAt'],
    );
  }

  static ChefModel fromJsonToChef(AuthModel data) {
    return ChefModel(
      id: data.id,
      name: data.name,
      email: data.email,
      role: data.role,
      createdAt: data.createdAt,
    );
  }

  static Map<String, dynamic> toChef(AuthModel data) {
    return {
      'id': data.id,
      'name': data.name,
      'email': data.email,
      'role': data.role,
      'createdAt': data.createdAt,
      'profile': {},
      'chefDetails': {},
    };
  }

  static AuthorModel fromJsonToAuthor(AuthModel data) {
    return AuthorModel(
      id: data.id,
      name: data.name,
      email: data.email,
      role: data.role,
      createdAt: data.createdAt,
    );
  }

  static Map<String, dynamic> toAuthor(AuthModel data) {
    return {
      'id': data.id,
      'name': data.name,
      'email': data.email,
      'role': data.role,
      'createdAt': data.createdAt,
      'profile': {},
      'courses': [],
      'recipes': [],
    };
  }

  static UserModel fromJsonToUser(AuthModel data) {
    return UserModel(
      id: data.id,
      name: data.name,
      email: data.email,
      role: data.role,
      createdAt: data.createdAt,
    );
  }

  static Map<String, dynamic> toUser(AuthModel data) {
    return {
      'id': data.id,
      'name': data.name,
      'email': data.email,
      'role': data.role,
      'createdAt': data.createdAt,
      'preferences': [],
    };
  }
}
