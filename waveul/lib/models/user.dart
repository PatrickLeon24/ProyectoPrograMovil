class User {
  final int id;
  final String name;
  final String lastName;
  final String username;
  final String passwordHash;
  final String email;
  final String? profileImage;
  final DateTime? birthDate;
  final String? phone;
  final DateTime createdAt;
  final bool isVerified;
  final DateTime? lastLogin;
  final String? verificationToken;
  final String? resetToken;
  final DateTime? resetTokenExpires;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.username,
    required this.passwordHash,
    required this.email,
    this.profileImage,
    this.birthDate,
    this.phone,
    required this.createdAt,
    required this.isVerified,
    this.lastLogin,
    this.verificationToken,
    this.resetToken,
    this.resetTokenExpires,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      lastName: json['last_name'] as String,
      username: json['username'] as String,
      passwordHash: json['password_hash'] as String,
      email: json['email'] as String,
      profileImage: json['profile_image'] as String?,
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'] as String)
          : null,
      phone: json['phone'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      isVerified: json['is_verified'] == 1 || json['is_verified'] == true,
      lastLogin: json['last_login'] != null
          ? DateTime.parse(json['last_login'] as String)
          : null,
      verificationToken: json['verification_token'] as String?,
      resetToken: json['reset_token'] as String?,
      resetTokenExpires: json['reset_token_expires'] != null
          ? DateTime.parse(json['reset_token_expires'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'username': username,
      'password_hash': passwordHash,
      'email': email,
      'profile_image': profileImage,
      'birth_date': birthDate?.toIso8601String(),
      'phone': phone,
      'created_at': createdAt.toIso8601String(),
      'is_verified': isVerified,
      'last_login': lastLogin?.toIso8601String(),
      'verification_token': verificationToken,
      'reset_token': resetToken,
      'reset_token_expires': resetTokenExpires?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, name: $name, lastName: $lastName, email: $email}';
  }
}
