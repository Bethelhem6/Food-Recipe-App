class LoginParam {
  final String email;
  final String password;
  final String type;

  LoginParam({
    required this.email,
    required this.password,
    this.type = 'parent',
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'type': type,
    };
  }

  factory LoginParam.fromJson(Map<String, dynamic> json) {
    return LoginParam(
      email: json['email'] as String,
      password: json['password'] as String,
      type: 'parent',
    );
  }
}
