class ChangePasswordParam {
  final String currentPassword;
  final String password;
  final String confirmPassword;

  ChangePasswordParam({
    required this.currentPassword,
    required this.password,
    required this.confirmPassword,
  });

  factory ChangePasswordParam.fromJson(Map<String, dynamic> json) {
    return ChangePasswordParam(
      currentPassword: json['currentPassword'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPassword': currentPassword,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
