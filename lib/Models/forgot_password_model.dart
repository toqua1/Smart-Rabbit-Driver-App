class ForgotPasswordResponse {
  final String status;
  final String message;
  final String otpToken;

  ForgotPasswordResponse({
    required this.status,
    required this.message,
    required this.otpToken,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      status: json['status'],
      message: json['message'],
      otpToken: json['otpToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'otpToken': otpToken,
    };
  }
}
