class User {
  final int userId;
  final String username;
  final String password;
  final String email;
  final String role; // 'student' or 'teacher'
  final String course; // e.g., 'email', 'google'
  final DateTime loginTime; // last login timestamp

  User({
    required this.userId,
    required this.username,
    required this.password,
    required this.email,
    required this.role,
    required this.course,
    required this.loginTime,
  });
}
