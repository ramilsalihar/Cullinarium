class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final List<String>? preferences;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    this.preferences,
  });
}
