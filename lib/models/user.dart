class User {
  final String username;
  final String? email;
  final String password;
  final String? confirmPassword;

  User({
    required this.username,
    required this.password,
    this.email,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'username': username,
      'password': password,
    };

    if (email != null) {
      data['email'] = email;
    }

    if (confirmPassword != null) {
      data['confirm_password'] = confirmPassword;
    }

    return data;
  }
}

class AuthResponse {
  final bool success;
  final String message;
  final int? userId; // Đảm bảo rằng userId là int

  AuthResponse({
    required this.success,
    required this.message,
    this.userId,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'],
      message: json['message'],
      userId: json['user_id'],
    );
  }
}
