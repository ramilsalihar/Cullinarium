class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final String phoneNumber;
  final List<String>? preferences;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.phoneNumber,
    this.preferences,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? createdAt,
    String? phoneNumber,
    List<String>? preferences,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      preferences: preferences ?? this.preferences,
    );
  }
}
