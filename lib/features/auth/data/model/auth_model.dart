class AuthModel {
  String accessToken;

  String refreshToken;
  String name;
  String id;
  AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.name,
    required this.id,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      name: json['name'],
      id: json['id'],
    );
  }
}
