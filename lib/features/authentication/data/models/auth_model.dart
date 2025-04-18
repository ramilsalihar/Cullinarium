class AuthModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String phoneNumber;
  final String createdAt;

  const AuthModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNumber,
    required this.createdAt,
  });
}
