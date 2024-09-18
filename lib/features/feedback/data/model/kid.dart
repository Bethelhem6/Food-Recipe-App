class Kid {
  final String? id;
  final String? parentId;
  final String? schoolId;
  final String? name;
  final int? age;
  final String? grade;
  final String? gender;
  final Address? address;
  final double? lat;
  final double? lng;
  final String? status;
  final DateTime? startDate;
  final bool? enabled;
  final bool? assigned;
  final String? remark;
  final String? distanceFromSchool;
  final String? archiveReason;
  final DateTime? createdBy;
  final DateTime? updatedBy;
  final DateTime? deletedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Kid({
    required this.id,
    this.parentId,
    required this.schoolId,
    required this.name,
    required this.age,
    required this.grade,
    required this.gender,
    required this.address,
    required this.lat,
    required this.lng,
    required this.status,
    required this.startDate,
    required this.enabled,
    required this.assigned,
    required this.remark,
    required this.distanceFromSchool,
    this.archiveReason,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Kid.fromJson(Map<String, dynamic> json) {
    return Kid(
      id: json['id'],
      parentId: json['parentId'],
      schoolId: json['schoolId'],
      name: json['name'],
      age: json['age'],
      grade: json['grade'],
      gender: json['gender'],
      address: Address.fromJson(json['address']),
      lat: json['lat'],
      lng: json['lng'],
      status: json['status'],
      startDate: DateTime.parse(json['startDate']),
      enabled: json['enabled'],
      assigned: json['assigned'],
      remark: json['remark'],
      distanceFromSchool: json['distanceFromSchool'],
      archiveReason: json['archiveReason'],
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

class Address {
  String? zip;
  String? city;
  String? state;
  String? country;
  String? commonName;

  Address({
    required this.zip,
    required this.city,
    required this.state,
    required this.country,
    this.commonName,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      zip: json['zip'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      commonName: json['commonName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'zip': zip,
      'city': city,
      'state': state,
      'country': country,
      'commonName': commonName,
    };
  }

  @override
  String toString() {
    return 'Address('
        'zip: $zip, '
        'city: $city, '
        'state: $state, '
        'country: $country, '
        'commonName: $commonName'
        ')';
  }
}
