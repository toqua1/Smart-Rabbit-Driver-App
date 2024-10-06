class SignUp {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String nationalId;
  final String nationalIdPhotoFace;
  final String nationalIdPhotoBack;
  final String driverLicensePhoto;
  final String address;
  final String role;

  SignUp({
    required this.driverLicensePhoto,
    required this.address,
    required this.role,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.nationalId,
    required this.nationalIdPhotoFace,
    required this.nationalIdPhotoBack,

  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'nationalId': nationalId,
      'nationalIdPhotoFace': nationalIdPhotoFace,
      'nationalIdPhotoBack': nationalIdPhotoBack,
      'license':driverLicensePhoto,
      'address':address,
      'role':role ,

    };
  }
}
