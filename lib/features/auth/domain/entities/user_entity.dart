// lib/features/auth/domain/entities/user_entity.dart

class UserEntity {
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final String? city;

  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    this.phone,
    this.city,
  });
}
