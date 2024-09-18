import '../../../feedback/data/model/kid.dart';

class Parent {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? gender;
  Address? address;
  bool? enabled;
  String? parentType;
  String? status;
  double? lng;
  double? lat;
  double? totalPayment;
  ProfileImage? profileImage;
  String? archiveReason;
  String? createdBy;
  String? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? deletedBy;
  List<dynamic>? kids;

  Parent({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.address,
    this.enabled,
    this.parentType,
    this.status,
    this.lng,
    this.lat,
    this.totalPayment,
    this.profileImage,
    this.archiveReason,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.deletedBy,
    this.kids,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      enabled: json['enabled'],
      parentType: json['parentType'],
      status: json['status'],
      lng: json['lng'] != null ? json['lng'].toDouble() : null,
      lat: json['lat'] != null ? json['lat'].toDouble() : null,
      totalPayment:
          json['totalPayment'] != null ? json['totalPayment'].toDouble() : null,
      profileImage: json['profileImage'] != null
          ? ProfileImage.fromJson(json['profileImage'])
          : null,
      archiveReason: json['archiveReason'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      deletedBy: json['deletedBy'],
      kids: json['kids'] != null ? List<dynamic>.from(json['kids']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'address': address?.toJson(),
      'enabled': enabled,
      'parentType': parentType,
      'status': status,
      'lng': lng,
      'lat': lat,
      'totalPayment': totalPayment,
      // 'profileImage': profileImage?.toJson(),
      // 'archiveReason': archiveReason,
      // 'createdBy': createdBy,
      // 'updatedBy': updatedBy,
      // 'createdAt': createdAt?.toIso8601String(),
      // 'updatedAt': updatedAt?.toIso8601String(),
      // 'deletedAt': deletedAt?.toIso8601String(),
      // 'deletedBy': deletedBy,
      // 'kids': kids,
    };
  }
}

class ProfileImage {
  String? filename;
  String? path;
  String? originalname;
  String? mimetype;
  int? size;

  ProfileImage({
    this.filename,
    this.path,
    this.originalname,
    this.mimetype,
    this.size,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      filename: json['filename'],
      path: json['path'],
      originalname: json['originalname'],
      mimetype: json['mimetype'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'path': path,
      'originalname': originalname,
      'mimetype': mimetype,
      'size': size,
    };
  }
}
