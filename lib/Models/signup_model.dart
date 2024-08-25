class SignUp {
  final String status;
  final SignUpDetails data;

  SignUp({
    required this.status,
    required this.data,
  });

  factory SignUp.fromJson(Map<String, dynamic> json) {
    return SignUp(
      status: json['status'],
      data: SignUpDetails.fromJson(json['data']['customer']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': {
        'customer': data.toJson(),
      },
    };
  }
}

class SignUpDetails {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final int nationalId;
  final String nationalIdPhotoFace;
  final String nationalIdPhotoBack;
  final String commercialRegister;
  final String taxNumberPhoto;
  final int taxNumber;
  final List<Address> addresses;
  final String productType;
  final int version;

  SignUpDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.nationalId,
    required this.nationalIdPhotoFace,
    required this.nationalIdPhotoBack,
    required this.taxNumberPhoto,
    required this.taxNumber,
    required this.addresses,
    required this.productType,
    required this.version,
    required this.commercialRegister,
  });

  factory SignUpDetails.fromJson(Map<String, dynamic> json) {
    var addressList = json['addresses'] as List;
    List<Address> addresses = addressList.map((i) => Address.fromJson(i)).toList();

    return SignUpDetails(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      nationalId: json['nationalId'],
      nationalIdPhotoFace: json['nationalIdPhotoFace'],
      nationalIdPhotoBack: json['nationalIdPhotoBack'],
      taxNumberPhoto: json['taxNumberPhoto'],
      commercialRegister: json['commercialRegister'],
      taxNumber: json['taxNumber'],
      addresses: addresses,
      productType: json['productType'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'nationalId': nationalId,
      'nationalIdPhotoFace': nationalIdPhotoFace,
      'nationalIdPhotoBack': nationalIdPhotoBack,
      'taxNumberPhoto': taxNumberPhoto,
      'taxNumber': taxNumber,
      'addresses': addresses.map((address) => address.toJson()).toList(),
      'productType': productType,
      '__v': version,
    };
  }
}

class Address {
  final String city;
  final String neighbourhood;
  final String street;

  Address({
    required this.city,
    required this.neighbourhood,
    required this.street,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      neighbourhood: json['neighbourhood'],
      street: json['street'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'neighbourhood': neighbourhood,
      'street': street,
    };
  }
}
