import 'package:emebet/features/feedback/data/model/kid.dart';

class RegistrationParam {
  String? name;
  String? id;
  String? email;
  String? phoneNumber;
  String? password;
  String? gender;
  Address? address;
  double? lng;
  double? lat;

  RegistrationParam({
    this.name,
    this.id,
    this.email,
    this.phoneNumber,
    this.password,
    this.gender,
    this.address,
    this.lng,
    this.lat,
  });

  // Factory constructor to create an instance from JSON
  factory RegistrationParam.fromJson(Map<String, dynamic> json) {
    return RegistrationParam(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      gender: json['gender'],
      address: Address.fromJson(json['address']),
      lng: json['lng'].toDouble(),
      lat: json['lat'].toDouble(),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'gender': gender,
      'lng': lng,
      'lat': lat,
      "address": address?.toJson()
    };
  }
}

class ConfirmOtpArguments {
  final bool isfromSignup;
  final String recievedverificationId;
  final String phoneNumber;

  ConfirmOtpArguments({
    required this.isfromSignup,
    required this.phoneNumber,
    required this.recievedverificationId,
  });
}
