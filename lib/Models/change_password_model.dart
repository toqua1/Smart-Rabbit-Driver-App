class ChangePasswordResponse {
  final String status;
  final String message;

  ChangePasswordResponse({required this.status, required this.message});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
