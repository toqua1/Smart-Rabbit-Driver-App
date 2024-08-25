class UserProfile {
  final String status;
  final Customer customer;

  UserProfile({
    required this.status,
    required this.customer,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      status: json['status'],
      customer: Customer.fromJson(json['data']['customer']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': {
        'customer': customer.toJson(),
      },
    };
  }
}

class Customer {
  final String name;
  final String email;
  final String phone;
  final List<Address> addresses;

  Customer({
    required this.name,
    required this.email,
    required this.phone,
    required this.addresses,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    var addressList = json['addresses'] as List;
    List<Address> addresses = addressList.map((i) => Address.fromJson(i)).toList();

    return Customer(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      addresses: addresses,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'addresses': addresses.map((address) => address.toJson()).toList(),
    };
  }
}

class Address {
  final String address;

  Address({
    required this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
    };
  }
}
