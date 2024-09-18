class FeedbackParam {
  final String subject;
  final String description;

  FeedbackParam({
    required this.subject,
    required this.description,
  });

  factory FeedbackParam.fromJson(Map<String, dynamic> json) {
    return FeedbackParam(
      subject: json['subject'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'description': description,
    };
  }
}
