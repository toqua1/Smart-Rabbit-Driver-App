class ResetOtpResponse {
  final String status;
  final String message;
  final String resetToken;

  ResetOtpResponse({
    required this.status,
    required this.message,
    required this.resetToken,
  });

  factory ResetOtpResponse.fromJson(Map<String, dynamic> json) {
    return ResetOtpResponse(
      status: json['status'],
      message: json['message'],
      resetToken: json['resetToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'resetToken': resetToken,
    };
  }
}
