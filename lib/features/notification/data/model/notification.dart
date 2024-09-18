class NotificationModel {
  String? id;
  String? title;
  String? body;
  String? to;
  bool? isSeen;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? deletedBy;
  String? archiveReason;
  NotificationModel(
    this.archiveReason,
    this.body,
    this.createdAt,
    this.createdBy,
    this.deletedAt,
    this.deletedBy,
    this.id,
    this.isSeen,
    this.title,
    this.to,
    this.updatedAt,
    this.updatedBy,
  );

  NotificationModel.fromJson(Map<String, dynamic> json) {
    archiveReason = json["archiveReason"];
    body = json["body"];
    createdAt = json["createdAt"]?.toString();
    createdBy = json["createdBy"];
    deletedAt = json["deletedAt"]?.toString();
    deletedBy = json["deletedBy"];
    id = json["id"];
    title = json["title"];
    to = json["to"];
    isSeen = json["isSeen"];
    updatedAt = json["updatedAt"]?.toString();
    updatedBy = json[""];
  }
}
