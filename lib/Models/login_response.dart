// class LoginResponse {
//   final String id;
//   final String name;
//   final String phone;
//   final String email;
//   final String token;
//   final bool isActive;
//
//   LoginResponse({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.email,
//     required this.token,
//     required this.isActive,
//   });
//
//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       id: json['driver']['_id'],
//       name: json['driver']['name'],
//       phone: json['driver']['phone'],
//       email: json['driver']['email'],
//       token: json['driver']['token'],
//       isActive: json['driver']['isActive'],
//     );
//   }
// }
class Driver {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String email;
  final String role;
  // final bool availability;
  // final bool isActive;
  final String token;

  Driver({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.role,
    // required this.availability,
    // required this.isActive,
    required this.token,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      email: json['email'],
      // availability: json['availability'],
      // isActive: json['isActive'],
      token: json['token'],
      role: json['role'],
    );
  }
}
