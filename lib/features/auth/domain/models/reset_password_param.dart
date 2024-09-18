class ResetPasswordParam {
  final String password;
  final String confirmPassword;
  final String phoneNumber;

  ResetPasswordParam({
    required this.password,
    required this.phoneNumber,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'confirmPassword': confirmPassword,
      'password': password,
      'type': "parent",
      'phoneNumber': phoneNumber,
    };
  }
}
