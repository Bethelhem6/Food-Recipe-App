class LoginParam {
  final String email;
  final String password;
  final String type;
  final String fcmId;

  LoginParam({
    required this.email,
    required this.password,
    required this.fcmId,
    this.type = 'parent',
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'type': type,
      'fcmId': fcmId,
    };
  }

  factory LoginParam.fromJson(Map<String, dynamic> json) {
    return LoginParam(
      email: json['email'],
      password: json['password'],
      fcmId: json['fcmId'],
      type: 'parent',
    );
  }
}
