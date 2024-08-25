class UserData {
  final String status;
  final UserDataDetails data;

  UserData({
    required this.status,
    required this.data,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      status: json['status'],
      data: UserDataDetails.fromJson(json['data']['customer']),
    );
  }
}

class UserDataDetails {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? token;

  UserDataDetails({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.token,
  });

  factory UserDataDetails.fromJson(Map<String, dynamic> json) {
    return UserDataDetails(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
