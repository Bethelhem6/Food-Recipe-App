class AnnounceDriverParam {
  final String? id;
  final String? status;
  final String? reason;

  AnnounceDriverParam({
    required this.id,
    required this.reason,
    this.status,
  });

  factory AnnounceDriverParam.fromJson(Map<String, dynamic> json) {
    return AnnounceDriverParam(
      id: json['id'],
      status: json['status'],
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': false,
      'reason': reason,
    };
  }
}
