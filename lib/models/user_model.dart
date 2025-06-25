class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  final String role;

  User({
    this.id = '',
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.avatar = '',
    this.role = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final userData = json['user'] as Map<String, dynamic>? ?? {};

    return User(
      id: userData['id'] ?? '',
      email: userData['email'] ?? '',
      firstName: userData['firstName'] ?? '',
      lastName: userData['lastName'] ?? '',
      avatar: userData['avatar'] ?? '',
      role: userData['role'] ?? '',
    );
  }
}