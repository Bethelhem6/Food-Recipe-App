
import 'package:emebet/features/feedback/data/model/kid.dart';

class AuthModel {
  String accessToken;
  String refreshToken;
  Profile profile;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.profile,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      profile: Profile.fromJson(json['profile']),
    );
  }
}

class Profile {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? type;
  bool? isActive;
  String? gender;
  Address? address;
  dynamic profileImage;
  String? fcmId;
  DateTime? createdBy;
  DateTime? updatedBy;
  DateTime? deletedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  // List<Role> roles;
  // List<dynamic> permissions;
  // Role currentRole;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.type,
    required this.isActive,
    this.gender,
    this.address,
    this.profileImage,
    this.fcmId,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    // required this.roles,
    // required this.permissions,
    // required this.currentRole,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      type: json['type'],
      isActive: json['isActive'],
      gender: json['gender'],
      address:
          json['address'] == null ? null : Address.fromJson(json['address']),
      profileImage: json['profileImage'],
      fcmId: json['fcmId'],
      createdBy:
          json['createdBy'] != null ? DateTime.parse(json['createdBy']) : null,
      updatedBy:
          json['updatedBy'] != null ? DateTime.parse(json['updatedBy']) : null,
      deletedBy:
          json['deletedBy'] != null ? DateTime.parse(json['deletedBy']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,

      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      // roles: (json['roles'] as List<dynamic>)
      //     .map((roleJson) => Role.fromJson(roleJson))
      //     .toList(),
      // permissions: json['permissions'].cast<dynamic>(),
      // currentRole: Role.fromJson(json['currentRole']),
    );
  }
}

class Role {
  String? id;
  String? name;
  String? key;
  bool? protected;
  DateTime? createdBy;
  DateTime? updatedBy;
  DateTime? deletedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Role({
    required this.id,
    required this.name,
    required this.key,
    required this.protected,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      key: json['key'],
      protected: json['protected'],
      createdBy:
          json['createdBy'] != null ? DateTime.parse(json['createdBy']) : null,
      updatedBy:
          json['updatedBy'] != null ? DateTime.parse(json['updatedBy']) : null,
      deletedBy:
          json['deletedBy'] != null ? DateTime.parse(json['deletedBy']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}
