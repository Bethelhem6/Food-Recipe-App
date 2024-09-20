  

class RegistrationParam {
  String? name;
  String? id;
  String? email;
  String? phoneNumber;
  String? password;
  String? gender;
  double? lng;
  double? lat;

  RegistrationParam({
    this.name,
    this.id,
    this.email,
    this.phoneNumber,
    this.password,
    this.gender,
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
