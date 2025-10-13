class LoginResponse {
  final String token;
  final String message;
  final bool success;

  LoginResponse({
    required this.token,
    required this.message,
    required this.success,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    token: json['token'] ?? '',
    message: json['message'] ?? '',
    success: json['success'] ?? false,
  );
}
